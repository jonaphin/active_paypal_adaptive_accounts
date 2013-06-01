class PaypalAdaptiveAccountsApiError < StandardError

  attr_reader :response

  def initialize response
    @response = response
  end

  def debug
    @response.inspect
  end

end
