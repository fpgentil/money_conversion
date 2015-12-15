require 'money_conversion/configuration'
require 'money_conversion/version'
require 'money_conversion/errors'
require 'money_conversion/validator'
require 'money_conversion/money'

module MoneyConversion
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
