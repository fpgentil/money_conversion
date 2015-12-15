module MoneyConversion
  class Validator
    class << self
      def validate_instance!(money_object)
        raise MoneyConversion::Errors::CurrencyRatesNotFound if Configuration.empty?
        raise MoneyConversion::Errors::CurrencyNotFound unless Configuration.valid_currency?(money_object.currency)
        money_object
      end

      def validate_conversion!(source_currency, target_currency)
        raise MoneyConversion::Errors::CurrencyNotFound unless Configuration.valid_currency?(source_currency)
        raise MoneyConversion::Errors::ConversionRateNotFound unless Configuration.valid_conversion?(source_currency, target_currency)
      end
    end
  end
end