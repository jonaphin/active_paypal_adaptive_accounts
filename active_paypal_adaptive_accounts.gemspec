# encoding: utf-8
Gem::Specification.new do |s|
  s.name        = "active_paypal_adaptive_accounts"
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jonathan Lancar"]
  s.email       = ["jonaphin@gmail.com"]
  s.homepage    = "http://github.com/jonaphin/active_paypal_adaptive_accounts"
  s.summary     = "ActiveMerchant PayPal Adaptive Accounts Library"
  s.description = <<-eof
    This library is meant to interface with PayPal's Adaptive Payment Gateway.
  eof

  s.required_rubygems_version = ">= 1.3.6"
  s.files = Dir.glob("lib/**/*") + %w(MIT-LICENSE README.md CHANGELOG.md)
  s.require_path = %w(lib)

  s.add_dependency(%q<activemerchant>, [">= 1.5.1"])
  s.add_dependency(%q<multi_json>, [">= 1.0.0"])
  s.add_dependency(%q<hashie>, [">= 1.2.0"])
  s.add_dependency(%q<money>, [">= 3.6.0"])
  s.add_dependency(%q<mocha>, [">= 0.10.0"])
end
