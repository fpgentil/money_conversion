module MoneyConversion
  module Comparator
    include Comparable

    def <=>(target)
      self.amount <=> converted_target(target).amount
    end

    private
    def converted_target(target)
      target.convert_to(self.currency)
    end

  end
end