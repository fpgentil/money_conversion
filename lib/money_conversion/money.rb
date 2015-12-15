module MoneyConversion
  class Money
    attr_reader :amount, :currency

    def initialize(amount, currency)
      @amount = amount
      @currency = currency
      Validator.validate_instance!(self)
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

    def convert_to(target_currency)
      return self if currency == target_currency
      Validator.validate_conversion!(currency, target_currency)

      arithmetic    = operation(target_currency)
      currency_rate = rate(target_currency)
      new_value     = amount.send(arithmetic, currency_rate)

      self.class.new(new_value, target_currency)
    end

    private
    def operation(target_currency)
      Configuration.currency_rates[target_currency] ? :* : :/
    end

    def rate(target_currency)
      Configuration.currency_rates[target_currency] || Configuration.currency_rates[currency]
    end
  end
end