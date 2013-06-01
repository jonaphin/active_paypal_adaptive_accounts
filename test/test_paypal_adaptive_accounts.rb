require_relative 'test_helper'

class TestPaypalAdaptiveAccounts < MiniTest::Unit::TestCase

  def setup
    @gateway = ActiveMerchant::Billing::PaypalAdaptiveAccounts.new(fixtures(:credentials))
  end

  def test_successful_verification_status
    assert response = @gateway.get_verification_status(fixtures(:account_options))
    assert_equal true, response.success?, "Unsuccessful Transaction"
  end
end
