require 'spec_helper'

describe MoneyConversion::Operator do
  let(:source_money) { Money.new(50, 'EUR') }
  let(:target_money) { Money.new(0, 'USD') }

  let(:operator) { described_class.new(source_money, target_money) }

  describe '.initialize' do
    it { expect(operator).not_to be_nil }
  end

  describe '#convert' do
    it { expect(operator.convert).to eq 55.135 }

    context 'between two currencies that are not base' do
      let(:new_source) { Money.new(50, 'USD') }
      let(:new_target) { Money.new(0, 'BRL') }

      let(:new_operator) { described_class.new(new_source, new_target) }

      it { expect(new_operator.convert).to eq 194.617416 }
    end
  end

  describe '#calculate' do
    it 'applies method to perform an arithmetic operation' do
      expect(operator.calculate(:+)).to eq 50
      expect(operator.calculate(:*)).to eq 0
    end
  end
end