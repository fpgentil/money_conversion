require 'spec_helper'

describe MoneyConversion::Operator do
  let(:source_money) { MoneyConversion::Money.new(50, 'EUR') }
  let(:target_money) { MoneyConversion::Money.new(0, 'USD') }

  let(:operator) { described_class.new(source_money, target_money) }

  describe '.initialize' do
    it { expect(operator).not_to be_nil }
  end

  describe '#convert' do
    it { expect(operator.convert).to eq 55.135 }
  end

  describe '#calculate' do
    pending
  end

  describe '#compare' do
    pending
  end

end