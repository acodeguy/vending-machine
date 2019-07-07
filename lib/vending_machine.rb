# a vending machine object
class VendingMachine
  attr_reader :inventory
  def initialize(coins: [], inventory: Inventory.new)
    @coins_available = coins
    @inventory = inventory
  end

  def load_coins(coins: [])
    @coins_available.concat(coins)
  end

  def coins_available
    @coins_available.sort
  end

  def sell(code:, coins: [])
    return 'Item not found.' unless item = @inventory.get_item(code: code)
    return 'Out of stock.' unless item[:quantity].positive?
    return 'Insert more money, try again.' unless coins.sum >= item[:price]

    coins_out = calculate_change(price: item[:price], coins_in: coins)
    { purchased: item[:name], change: coins_out }
  end

  private

  def calculate_change(price: 0, coins_in: [])
    change_due = coins_in.sum - price
    change = []

    @coins_available.sort.reverse.each do |coin|
      if change_due >= coin
        change_due -= coin
        change.push(coin)
        @coins_available.delete(coin)
      end
    end

    @coins_available.concat(coins_in)
    change.sort
  end
end
