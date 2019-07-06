# a vending machine object
class VendingMachine
  attr_reader :coins_available, :inventory

  def initialize(coins: [], inventory: [])
    @coins_available = coins
    @inventory = inventory
  end
end
