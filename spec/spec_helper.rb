$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
end

require 'money_conversion'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.before do
    MoneyConversion.configure do |config|
      config.currency_base = 'EUR'
      config.currency_rates = {
        'USD' => 1.1027,
        'BRL' => 4.2924
      }
    end
  end
end