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
  end

  describe '#calculate' do
    it 'applies method to perform an arithmetic operation' do
      expect(operator.calculate(:+)).to eq 50
      expect(operator.calculate(:*)).to eq 0
    end
  end

  describe '#compare' do
    it 'applies method to compare source and target' do
      expect(operator.compare(:>)).to be_truthy
      expect(operator.compare(:<)).to be_falsey
    end
  end

end