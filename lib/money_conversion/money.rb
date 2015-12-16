module MoneyConversion
  class Money
    attr_reader :amount, :currency

    def initialize(amount, currency)
      @amount = amount.round(2)
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
      "#{'%.2f' % amount} #{currency}"
    end

    def convert_to(target_currency)
      target_money = self.class.new(0, target_currency)
      self.class.new(operator(target_money, to_convert: true).convert, target_currency)
    end

    def + (target_money)
      self.class.new(operator(target_money).calculate(:+), currency)
    end

    def - (target_money)
      self.class.new(operator(target_money).calculate(:-), currency)
    end

    def == (target_money)
      operator(target_money).compare(:==)
    end

    def > (target_money)
      operator(target_money).compare(:>)
    end

    def < (target_money)
      operator(target_money).compare(:<)
    end

    def * (value)
      target_money = self.class.new(value, currency)
      self.class.new(operator(target_money).calculate(:*), currency)
    end

    def / (value)
      target_money = self.class.new(value, currency)
      self.class.new(operator(target_money).calculate(:/), currency)
    end

    private
    def operator(target_money, options={})
      target_money = target_money.convert_to(currency) unless options[:to_convert]
      Operator.new(self, target_money)
    end
  end
end