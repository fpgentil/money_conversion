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
      target_money = self.class.new(0, target_currency)
      self.class.new(operator(target_money).convert, target_currency)
    end

    private
    def operator(target_money)
      Operator.new(self, target_money)
    end
  end
end