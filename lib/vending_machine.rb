# a vending machine object
class VendingMachine
  attr_reader :coins_available

  def initialize(coins: [])
    @coins_available = coins
  end
end
