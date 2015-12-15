module MoneyConversion
  class Money
    attr_reader :amount, :currency

    def initialize(amount, currency)
      raise MoneyConversion::Errors::CurrencyRatesNotFound if Configuration.empty?
      raise MoneyConversion::Errors::CurrencyNotFound unless Configuration.valid_currencies.include?(currency)

      @amount = amount
      @currency = currency
    end

    def self.conversion_rates(base, rates)
      MoneyConversion.configure do |config|
        config.currency_base = base
        config.currency_rates = rates
      end
    end

    def inspect
      "#{'%.2f' % amount} #{@currency}"
    end
  end
end