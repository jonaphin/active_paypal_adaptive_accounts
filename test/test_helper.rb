# encoding: utf-8
$:.unshift File.expand_path('../../lib', __FILE__)

require 'yaml'
require 'mocha'
require 'minitest/autorun'
require 'active_merchant'
require 'active_paypal_adaptive_accounts'

ActiveMerchant::Billing::Base.mode = :test

module MiniTest
  class Unit
    class TestCase

      private

      def account_options
        {
          account: {
            email: "sender@example.com"
          },
          first_name: "Sender",
          last_name: "Example"
        }
      end

      def all_fixtures
        @@fixtures ||= load_fixtures
      end

      def fixtures(key)
        data = all_fixtures[key] || raise(StandardError,
                                    "No fixture data was found for '#{key}'")
        data.dup
      end

      def load_fixtures
        file = File.join(File.dirname(__FILE__), 'fixtures.yml')
        yaml_data = YAML.load(File.read(file))
        symbolize_keys(yaml_data)
        yaml_data
      end

      def symbolize_keys(hash)
        return unless hash.is_a?(Hash)
        hash.symbolize_keys!
        hash.each{|k,v| symbolize_keys(v)}
      end
    end
  end
end
