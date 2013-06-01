# -*- coding: utf-8 -*-
require 'money'
require File.dirname(__FILE__) + '/paypal_adaptive_accounts/ext'
require File.dirname(__FILE__) + '/paypal_adaptive_accounts/exceptions'
require File.dirname(__FILE__) + '/paypal_adaptive_accounts/adaptive_accounts_response'

module ActiveMerchant
  module Billing

    class PaypalAdaptiveAccounts < Gateway
      TEST_URL = 'https://svcs.sandbox.paypal.com/AdaptiveAccounts/'
      LIVE_URL = 'https://svcs.paypal.com/AdaptiveAccounts'

      self.supported_countries = ['US']
      self.homepage_url = 'http://x.com/'
      self.display_name = 'Paypal Adaptive Accounts'

      def initialize(options = {})
        requires!(options, :login, :password, :signature, :appid)
        @options = options.dup
        super
      end

      def get_verified_status(options)
        commit('GetVerifiedStatus', build_get_verfied_status_request(options))
      end

      def debug
        {:url => @url, :request => @xml, :response => @response.json}
      end

      private

      def build_get_verfied_status_request(options)
        @xml = ''
        xml = Builder::XmlMarkup.new :target => @xml, :indent => 2
        xml.instruct!
        xml.GetVerifiedStatus do |x|
          x.requestEnvelope do |x|
            x.detailLevel 'ReturnAll'
            x.errorLanguage options[:error_language] ||= 'en_US'
          end
          x.emailAddress options[:email] if options.has_key?(:email)
          x.accountIdentifier do |x|
            opts = options[:account]

            x.emailAddress opts[:email] if opts.has_key?(:email)
            x.mobilePhoneNumber opts[:phone] if opts.has_key?(:phone)
            x.accountId opts[:id] if opts.has_key?(:id)
          end if options.has_key?(:account)
          x.firstName options[:first_name]
          x.lastName options[:last_name]
          x.matchCriteria options[:match] ||= 'NAME'
        end
      end

      def commit(action, data)
        @response = AdaptiveAccountsResponse.new(post_through_ssl(action, data), data, action)
      end

      def post_through_ssl(action, parameters = {})
        headers = {
          "X-PAYPAL-REQUEST-DATA-FORMAT" => "XML",
          "X-PAYPAL-RESPONSE-DATA-FORMAT" => "JSON",
          "X-PAYPAL-SECURITY-USERID" => @options[:login],
          "X-PAYPAL-SECURITY-PASSWORD" => @options[:password],
          "X-PAYPAL-SECURITY-SIGNATURE" => @options[:signature],
          "X-PAYPAL-APPLICATION-ID" => @options[:appid],
        }
        action_url(action)
        request = Net::HTTP::Post.new(@url.path)
        request.body = @xml
        headers.each_pair { |k,v| request[k] = v }
        request.content_type = 'text/xml'
        server = Net::HTTP.new(@url.host, 443)
        server.use_ssl = true
        # OSX: sudo port install curl-ca-bundle
        server.verify_mode = OpenSSL::SSL::VERIFY_PEER
        server.ca_path = '/etc/ssl/certs' if File.exists?('/etc/ssl/certs') # Ubuntu
        server.ca_file = '/opt/local/share/curl/curl-ca-bundle.crt' if File.exists?('/opt/local/share/curl/curl-ca-bundle.crt') # Mac OS X
        server.start { |http| http.request(request) }.body
      end

      def endpoint_url
        test? ? TEST_URL : LIVE_URL
      end

      def test?
        @options[:test] || Base.gateway_mode == :test
      end

      def action_url(action)
        @url = URI.parse(endpoint_url + action)
      end
    end
  end
end
