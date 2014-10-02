# Configure for local environment
begin; require_relative '.env.rb'; rescue LoadError; end

# Configure unconfigured variables using ||=. Those keys aren't real, so don't
# even bother trying them. You'll need your own account and environment ;-)

ENV['SPREEDLY_HOST'] ||= 'https://core.spreedly.com'
ENV['SPREEDLY_API_URL'] ||= ENV['SPREEDLY_HOST'] + '/v1/payment_methods'
ENV['SPREEDLY_JSONP_API_URL'] ||= ENV['SPREEDLY_HOST'] + '/v1/payment_methods.js'
ENV['SPREEDLY_ENVIRONMENT_KEY'] ||= 'OB9909MNZj62u9U4VAz3lAAPZcp'
ENV['SPREEDLY_ACCESS_SECRET'] ||= 'MIMo7gJrSi3LnJGdRrOZeBBowXmDVE4zEgyHQS91tIqZiJ2oiy6PRt5XJVXG7hcz'
ENV["SPREEDLY_GATEWAY_FOR_CREDIT_CARD"] ||=  "StuXzUJ5Khe3Wes31T0M4uNnjv9"

ENV['APP_JS_URL'] ||= '/js/main.js'
ENV['JQUERY_PAYMENT_JS_URL'] ||= '/js/jquery.payment.js'
ENV['VALIDATOR_JS_URL'] ||= '/js/validator.js'
