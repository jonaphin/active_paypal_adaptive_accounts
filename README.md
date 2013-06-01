# Active PayPal Adaptive Accounts

This library is meant to interface with PayPal's Adaptive Payment Gateway.
It enables the API check for the verified status of a paypal account.

[Active Merchant]:http://www.activemerchant.org

See the [Active PayPal Adaptive Accounts](https://www.paypalobjects.com/webstatic/en_US/developer/docs/pdf/pp_adaptiveaccounts.pdf) manual.

## Supported

* Get Verified Status API

## Installation

Add the following line to your app's Gemfile:

    gem "active_paypal_adaptive_accounts"

    bundle install

### Init
```ruby
    gateway =  ActiveMerchant::Billing::PaypalAdaptiveAccounts.new(
      login: "acutio_1313133342_biz_api1.gmail.com",
      password: "1255043567",
      signature: "Abg0gYcQlsdkls2HDJkKtA-p6pqhA1k-KTYE0Gcy1diujFio4io5Vqjf",
      appid: "APP-80W284485P519543T"
    )
```

### Paypal Account Status Verification
```ruby
    response = gateway.get_verified_status (
      email: "Seller Email Address",
      account: {
        email: "Seller Email",
        phone: "Seller Phone Number",
        id: "Seller Paypal ID"
      }
    )
```

## Testing

First modify the `test/fixtures.yml` to fit your app credentials (You
will need at least a PayPal developer account).

After that you can run them like this:

    $ ruby -Ilib test/test_paypal_adaptive_accounts.rb

## Debugging

Use either gateway.debug or response.debug this gives you the json
response, the xml sent and the url it was posted to.

From the Rails console it can be accessed like such:

    ActiveMerchant::Billing::PaypalAdaptiveAccounts

`PaypalAdaptiveAccounts#debug` or `AdaptiveAccountsResponse#debug` return the raw
xml request, raw json response and the URL of the endpoint.

## TODO

* Documentation.
* Implementing Other Features of AdaptiveAccounts

## Contributors

* Jonathan Lancar (<http://www.genesx.com/>)

## This Gem is heavily based on the work of:
* [Jose Pablo Barrantes](<http://jpablobr.com/>)
  - [active_paypal_adaptive_payment](https://github.com/jpablobr/active_paypal_adaptive_payment)

## Other previous contributors where some code was taken from.
* [Tommy Chheng](http://tommy.chheng.com)
  - [Paypal Adaptive Ruby Gem Released](http://tommy.chheng.com/2009/12/29/paypal-adaptive-ruby-gem-released/)
  - [paypal_adaptive](https://github.com/tc/paypal_adaptive)

* [lamp (Matt)](https://github.com/lamp)
  - [paypal_adaptive_gateway](https://github.com/lamp/paypal_adaptive_gateway)

* [sentientmonkey (Scott Windsor)](https://github.com/sentientmonkey)
  - [active_merchant](https://github.com/sentientmonkey/active_merchant)

* [sijokg](https://github.com/sijokg)
  - [active_merchant](https://github.com/sijokg/active_merchant)

## Note on Patches/Pull Requests:

* Fork the project.
* Make your feature addition or bug fix.
* Send me a pull request. Bonus points for topic branches.

## Copyright:

(The MIT License)

Copyright 2013 Jonathan Lancar. MIT Licence, so go for it.

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, an d/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
