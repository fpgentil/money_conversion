require 'spec_helper'

describe MoneyConversion::Money do
  describe '.conversion_rates' do
    let(:hash_rates) { { 'BRL' => 3.78 } }
    before { described_class.conversion_rates('USD', hash_rates) }

    it 'matches base and rates' do
      expect(MoneyConversion.configuration.currency_base).to eq 'USD'
      expect(MoneyConversion.configuration.currency_rates).to eq hash_rates
    end
  end

  describe '.initialize' do
    let(:money) { described_class.new(50, currency) }

    context 'without any configuration' do
      let(:currency) { 'EUR' }

      it 'assigns amount and currency' do
        expect(money.amount).to eq 50
        expect(money.currency).to eq 'EUR'
      end
    end

    context 'with a valid configuration' do
      before { MoneyConversion.configure{|config| config.currency_base = nil} }
      let(:currency) { 'EUR' }

      it 'raises CurrencyRatesNotFound exception' do
        expect{ money }.to raise_error MoneyConversion::Errors::CurrencyRatesNotFound
      end
    end

    context 'without a valid currency' do
      let(:currency) { 'ABC' }

      it 'raises CurrencyNotFound exception' do
        expect{ money }.to raise_error MoneyConversion::Errors::CurrencyNotFound
      end
    end
  end

  describe '#inspect' do
    let(:money) { described_class.new(50, 'EUR') }

    it 'outputs formated value and currency' do
      expect(money.inspect).to eq '50.00 EUR'
    end
  end

  describe '#convert_to' do
    let(:money) { described_class.new(50, currency) }
    let(:new_money) { described_class.new(value, new_currency) }

    context 'with valid conversion' do
      context 'from eur to usd' do
        let(:currency) { 'EUR' }
        let(:new_currency) { 'USD' }
        let(:value) { 50 * 1.1027 }

        it 'multiplies the value and the rate' do
          expect(money.convert_to(new_currency).amount).to eq new_money.amount
          expect(money.convert_to(new_currency).currency).to eq new_money.currency
        end
      end

      context 'from usd to eur' do
        let(:currency) { 'USD' }
        let(:new_currency) { 'EUR' }
        let(:value) { 50 / 1.1027 }

        it 'divides the value and the rate' do
          expect(money.convert_to(new_currency).amount).to eq new_money.amount
          expect(money.convert_to(new_currency).currency).to eq new_money.currency
        end
      end
    end

    context 'with invalid conversion' do
      let(:money) { described_class.new(50, 'USD') }

      it { expect{ money.convert_to('BRL') }.to raise_error MoneyConversion::Errors::ConversionRateNotFound }
    end
  end

  describe 'arithmetic operations' do
    let(:fifty_euro) { described_class.new(50, 'EUR') }
    let(:twenty_usd) { described_class.new(20, 'USD') }

    describe 'sum' do
      let(:result) { fifty_euro + twenty_usd }

      it { expect(result.amount).to eq 68.14 }
      it { expect(result.currency).to eq 'EUR' }
      it { expect(result.class).to eq MoneyConversion::Money }
    end

    describe 'subtraction' do
      let(:result) { fifty_euro - twenty_usd }

      it { expect(result.amount).to eq 31.86 }
      it { expect(result.currency).to eq 'EUR' }
      it { expect(result.class).to eq MoneyConversion::Money }
    end

    describe 'multiplication' do
      let(:result) { fifty_euro * 2 }

      it { expect(result.amount).to eq 100 }
      it { expect(result.currency).to eq 'EUR' }
      it { expect(result.class).to eq MoneyConversion::Money }
    end

    describe 'division' do
      let(:result) { fifty_euro / 2 }

      it { expect(result.amount).to eq 25 }
      it { expect(result.currency).to eq 'EUR' }
      it { expect(result.class).to eq MoneyConversion::Money }
    end

    describe 'equality' do
      let(:result) { fifty_euro == twenty_usd }

      it { expect(result).to be_falsey }
    end

    describe 'higher than' do
      let(:result) { fifty_euro > twenty_usd }

      it { expect(result).to be_truthy }
    end

    describe 'lower than' do
      let(:result) { fifty_euro < twenty_usd }

      it { expect(result).to be_falsey }
    end
  end

end