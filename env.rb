# Configure for local environment
begin; require_relative '.env.rb'; rescue LoadError; end

# Configure unconfigured variables using ||=. Those keys aren't real, so don't
# even bother trying them. You'll need your own account and environment ;-)

ENV['SPREEDLY_HOST'] ||= 'https://core.spreedly.com'
ENV['SPREEDLY_API_URL'] ||= ENV['SPREEDLY_HOST'] + '/v1/payment_methods'
ENV['SPREEDLY_JSONP_API_URL'] ||= ENV['SPREEDLY_HOST'] + '/v1/payment_methods.js'
ENV['SPREEDLY_ENVIRONMENT_KEY'] ||= '98pj38QncZT7KYRmDTufi9OIjUb'
ENV['SPREEDLY_ACCESS_SECRET'] ||= 'UFd3PIclun6PINL5VLGkGOqTt4ljOpGBtIb7Aso3GOy4AhCw4ev4MtnJZIOLnxKB'

ENV['APP_JS_URL'] ||= '/js/main.js'
ENV['JQUERY_PAYMENT_JS_URL'] ||= '/js/jquery.payment.js'
ENV['VALIDATOR_JS_URL'] ||= '/js/validator.js'
