require 'money_conversion/configuration'
require "money_conversion/version"

module MoneyConversion
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
