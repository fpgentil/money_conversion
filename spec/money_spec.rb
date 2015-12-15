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
end