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

  def load_items(items: [])
    items.each do |item|
      index = @inventory.find_index { |inv_item| inv_item[:code] == item[:code] }
      if index
        @inventory[index][:quantity] += item[:quantity]
      else
        @inventory << item
      end
    end
  end
end
