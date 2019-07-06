# a vending machine object
class VendingMachine
  attr_reader :inventory

  def initialize(coins: [], inventory: [])
    @coins_available = coins
    @inventory = inventory
  end

  def load_coins(coins: [])
    @coins_available.concat(coins)
  end

  def coins_available
    @coins_available.sort
  end
end
