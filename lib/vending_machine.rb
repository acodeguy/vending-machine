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

  def sell(code:, coins: [])
    item = @inventory.find { |i| i[:code] == code }
    raise 'Insufficient funds.' if coins.sum < item[:price]

    returned_coins = calculate_change(price: item[:price], coins_in: coins)
    { purchased: item[:name], change: returned_coins }
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
