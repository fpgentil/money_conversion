require 'spec_helper'

describe MoneyConversion::Validator do

  describe '.validate_instance!' do
    let(:money) { Money.new(50, currency) }

    context 'with a valid instance' do
      let(:currency) { 'EUR' }

      it { expect(described_class.validate_instance!(money).amount).to eq money.amount }
      it { expect(described_class.validate_instance!(money).currency).to eq money.currency }
    end

    context 'with an invalid instance' do
      let(:currency) { 'ABC' }

      it 'raises exception' do
        expect{ described_class.validate_instance!(money) }.to raise_error MoneyConversion::Errors::CurrencyNotFound
      end
    end
  end

  describe '.validate_conversion!' do
    context 'with a valid conversion' do
      it { expect { described_class.validate_conversion!('EUR', 'USD') }.to_not raise_error }
    end

    context 'with an invalid conversion' do
      context 'when currency is invalid' do
        it { expect { described_class.validate_conversion!('ABC', 'USD') }.to raise_error MoneyConversion::Errors::CurrencyNotFound }
      end

      context 'when conversion is invalid' do
        it { expect(described_class.validate_conversion!('USD', 'BRL')).to be_falsey }
      end
    end
  end

  describe '.validate_conversion_param!' do
    let(:money) { Money.new(50, 'EUR') }

    context 'with a valid param' do
      it { expect(described_class.validate_conversion_param!(money)).to be_nil }
    end

    context 'when an invalid param' do
      it { expect{ described_class.validate_conversion_param!('EUR') }.to raise_error MoneyConversion::Errors::InvalidMoneyArgument }
    end
  end
end