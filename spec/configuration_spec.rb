require 'spec_helper'

describe MoneyConversion::Configuration do
  describe '.empty?' do
    context 'without a base or rates' do
      before { MoneyConversion.configure{|config| config.currency_base = nil} }
      it { expect(described_class.empty?).to be_truthy }
    end

    context 'when everything is ok' do
      it { expect(described_class.empty?).to be_falsey }
    end
  end

  describe '.valid_currencies' do
    it 'return list with valid currencies' do
      expect(described_class.valid_currencies).to eq ['EUR', 'USD', 'BRL']
    end
  end
end