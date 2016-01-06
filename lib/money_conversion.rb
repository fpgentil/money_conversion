require 'money_conversion/configuration'
require 'money_conversion/version'
require 'money_conversion/errors'
require 'money_conversion/operator'
require 'money_conversion/comparator'
require 'money_conversion/converter'
require 'money_conversion/validator'
require 'money'

module MoneyConversion
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
