module MoneyConversion
  module Operator
    def + (target)
      self.class.new((amount + converted_target(target).amount), currency)
    end

    def - (target)
      self.class.new((amount - converted_target(target).amount), currency)
    end

    def * (value)
      self.class.new((amount * value), currency)
    end

    def / (value)
      self.class.new((amount / value), currency)
    end

    private
    def converted_target(target)
      target.convert_to(currency)
    end

  end
end