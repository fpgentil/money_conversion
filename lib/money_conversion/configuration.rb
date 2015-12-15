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
  end
end
