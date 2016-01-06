module MoneyConversion
  module Comparator
    include Comparable

    def <=>(target)
      self.amount <=> target.convert_to(currency).amount
    end

  end
end