module MoneyConversion
  class Operator
    attr_reader :source_money, :target_money

    def initialize(source_money, target_money)
      @source_money = source_money
      @target_money = target_money
    end

    def convert
      return source_money.amount if source_money.currency == target_money.currency
      if Validator.validate_conversion!(source_money.currency, target_money.currency)
        source_money.amount.send(operation, rate)
      else
        base_conversion = source_money.amount.send(inversion_operation, base_rate).round(2)
        base_conversion.send(operation, rate)
      end
    end

    def calculate(method)
      source_money.amount.send(method, target_money.amount.to_f)
    end

    def compare(method)
      calculate(method)
    end

    private
    def operation
      Configuration.currency_rates[target_money.currency] ? :* : :/
    end

    def rate
      Configuration.currency_rates[target_money.currency] || Configuration.currency_rates[source_money.currency]
    end

    def inversion_operation
      Configuration.currency_rates[target_money.currency] ? :/ : :*
    end

    def base_rate
      Configuration.currency_rates[source_money.currency]
    end
  end
end