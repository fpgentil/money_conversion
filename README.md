# MoneyConversion

This is a Ruby gem which performs currency conversion and arithmetics with different currencies.

## Installation

Clone this github repository and then execute:

```ruby
$ bundle install
```

## Run the tests

```ruby
$ rake spec
```

## Usage

### Initialize
The currency rates can be initialized in your rack-based application with the following code

```ruby
MoneyConversion.configure do |config|
  config.currency_base = 'EUR'
  config.currency_rates = {
    'USD' => 1.1027,
    'BRL' => 4.2924
  }
end
```

### Manual usage

```ruby
$ rake console

# Conversion rates can also be set using the method `conversion_rates`
> Money.conversion_rates('EUR', {
'USD' => 1.11,
'Bitcoin' => 0.0047
})

fifty_eur = Money.new(50, 'EUR')
# => 50.00 EUR

> fifty_eur.convert_to('USD') 
# => 55.50 USD

> fifty_eur.to_usd
# => 55.50 USD

> fifty_eur.to_bitcoin
# => 0.24 Bitcoin

> twenty_dollars = Money.new(20, 'USD')

> twenty_dollars.convert_to('EUR')
# => 18.02 EUR

> twenty_dollars.to_eur
# => 18.02 EUR

> twenty_dollars.to_bitcoin
# 0.08 Bitcoin

## ARITHMETICS
> fifty_eur + twenty_dollars 
# => 68.02 EUR

> fifty_eur - twenty_dollars 
# => 31.98 EUR

> fifty_eur / 2 
# => 25 EUR

> twenty_dollars * 3 
# => 60 USD

# COMPARISON
> twenty_dollars == Money.new(20, 'USD') 
# => true

> twenty_dollars == Money.new(30, 'USD')
# => false

> fifty_eur_in_usd = fifty_eur.convert_to('USD')
> fifty_eur_in_usd == fifty_eur
# => true

> twenty_dollars > Money.new(5, 'USD') 
# => true

> twenty_dollars < fifty_eur 
# => true

```

## Bried explanation

The model `Money` is the main model responsible to handle the instances. It uses the `Operation` to actually perform the arithmetics and also compare two `Money` objects. The model `Validator` is the one responsible to, using `Configuration`, validate parameters and also operations.

## Contributing

1. Fork it ( https://github.com/fpgentil/money_conversion/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

