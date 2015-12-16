module MoneyConversion
  class Errors
    class CurrencyRatesNotFound < StandardError; end
    class CurrencyNotFound < StandardError; end
    class InvalidMoneyArgument < StandardError ; end
  end
end