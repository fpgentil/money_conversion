require 'spec_helper'

describe MoneyConversion do
  it 'has a version number' do
    expect(MoneyConversion::VERSION).not_to be_nil
  end

  it 'has a currency base' do
    expect(MoneyConversion.configuration.currency_base).not_to be_nil
  end

  it 'has a currency rates' do
    expect(MoneyConversion.configuration.currency_rates).not_to be_nil
  end
end
