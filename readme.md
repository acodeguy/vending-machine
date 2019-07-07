# Vending Machine
[![Build Status](https://travis-ci.org/acodeguy/vending-machine.svg?branch=master)](https://travis-ci.org/acodeguy/vending-machine) [![Maintainability](https://api.codeclimate.com/v1/badges/7674244ea945e8484548/maintainability)](https://codeclimate.com/github/acodeguy/vending-machine/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/7674244ea945e8484548/test_coverage)](https://codeclimate.com/github/acodeguy/vending-machine/test_coverage) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/0484f5786dc148fea521b7d5d7b1618a)](https://www.codacy.com/app/acodeguy/vending-machine?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=acodeguy/vending-machine&amp;utm_campaign=Badge_Grade)

## The Challenge
Design a vending machine that behaves as follows:
*  The selected item is returned if enough money is inserted
*  It should give change where necessary
*  It should ask for more more if not enough was inserted
*  It should start with an initial load of items and coins (for change)
*  It should allow re-loading of coins/items at a later point
*  It should keep track of its items and coins

## Approach
I chose to carve-off the inventory functionality into its own class and give the option to inject the inventory dependency into the VendingMachine object on creation, leaving the VendingMachine objct open to get its inventory from another source.

## Getting Started
To clone the repo to your hard drive and install all necessary dependencies, run the following:

```bash
git clone git@github.com:acodeguy/vending-machine.git
cd vending-machine
bundle install
```

## Tests
After installing all dependencies as above using the bundle command, feel free to run the test suite using RSpec:
```bash
rspec
```

## Using the Vending Machine
Fire-up IRB with the two RUby source files included:

```bash
irb -r ./lib/inventory.rb -r ./lib/vending_machine.rb
```
I recommend having an Inventory created first. Inventory objects can be created with an array of items:

### Preparing the inital stock and change
```ruby
stock = [
  { name: 'Twix', price: 0.45, code: 'A1', quantity: 1 },
  { name: 'Buttons', code: 'A2', price: 0.95, quantity: 1 },
  { name: 'Soda', code: 'A3', price: 1.50, quantity: 1 },
  { name: 'Gum', code: 'A4', price: 0.35, quantity: 0 }
]

initial_coins = [0.01, 0.02, 0.05, 0.10, 0.20, 0.50, 1.00, 2.00]

inventory = Inventory.new(items: stock)

vending_machine = VendingMachine.new(coins: initial_coins, inventory: inventory)
```
Our machine is ready to dispense! Let's buy a Twix (code A1) with a £2 coin and see what happens:

### Buying an item
```ruby
vending_machine.sell(code: 'A1', coins: [2.00])
=> {:purchased=>"Twix", :change=>[0.05, 0.5, 1.0]}
```
Above, IRB returns a hash with the name of the item bought and your change in coins. The vending machine is designed to give you the fewest number of coins possible when returning change; who wants £1.55 in 1p coins!

Checking the inventory will show that we're now sold-out of Twix bars:
```ruby
 vending_machine.inventory.items

 => [{:name=>"Twix", :price=>0.45, :code=>"A1", :quantity=>0}, {:name=>"Buttons", :code=>"A2", :price=>0.95, :quantity=>1}, {:name=>"Soda", :code=>"A3", :price=>1.5, :quantity=>1}, {:name=>"Gum", :code=>"A4", :price=>0.35, :quantity=>0}] 
 ```
 You'll also notice that the coin we paid with is now available inside the machine's array of coins to make change in the future. The coins given as change for the Twix bar are also not available anymore (compared to the initial_coins array). Nice.
 ```ruby
 vending_machine.coins_available
 => [0.01, 0.02, 0.1, 0.2, 2.0, 2.0] 
 ```

 ### Loading new coins

 To load the machine with more coins, let's first check what's in the machine:
 ```ruby
 vending_machine.coins_available
=> [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1.0, 2.0]
```
Let's load another three 50p coins, then check again:
```ruby
new_coins = [0.5, 0.5, 0.5]

vending_machine.load_coins(coins: new_coins)

vending_machine.coins_available

=> [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 0.5, 0.5, 0.5, 1.0, 2.0]
```
Notice there are now four 50p coins where there was only one before.

### Loading new stock
Load up your items into an array of hashes then load them with #load_items:
```ruby
new_stock = [
  { name: 'Swizzles', code: 'A5', price: 1.25, quantity: 2 },
  { name: 'Dip Dab', code: 'A6', price: 0.40, quantity: 2 },
  { name: 'Twix', price: 0.45, code: 'A1', quantity: 1 }
]

vending_machine.inventory.load_items(items: new_stock)
```
Your vending machine is ready to dispense new goodies again!

## Dependencies
*  Ruby 2.6.0
*  RSpec
*  Rubocop