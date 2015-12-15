module MoneyConversion
  class Configuration
    attr_accessor :currency_base, :currency_rates

    def self.empty?
      [:currency_base, :currency_rates].each do |attribute|
        return true if MoneyConversion.configuration.send(attribute).nil?
      end
      false
    end

    def self.valid_currencies
      [
        MoneyConversion.configuration.currency_base,
        MoneyConversion.configuration.currency_rates.keys,
      ].flatten.uniq
    end

    def self.valid_currency?(currency)
      valid_currencies.include?(currency)
    end

    def self.valid_conversion?(source, target)
      !(Configuration.currency_base != source && Configuration.currency_base != target)
    end

    def self.currency_base
      MoneyConversion.configuration.currency_base
    end

    def self.currency_rates
      MoneyConversion.configuration.currency_rates
    end
  end
end
