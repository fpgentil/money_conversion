module MoneyConversion
  class Errors
    class CurrencyRatesNotFound < StandardError; end
    class CurrencyNotFound < StandardError; end
  end
end