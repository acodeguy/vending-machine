# handles inventory tasks for the vending machine
class Inventory
  attr_reader :items

  def initialize(items: [])
    @items = items
  end

  def vend(code:)
    item = items.find { |i| i[:code] == code }
    raise 'Out of stock.' unless item[:quantity].positive?

    decrement_stock(code: item[:code])
    item[:name]
  end

  def load_items(items: [])
    items.each do |item|
      index = @items.find_index { |inv_item| inv_item[:code] == item[:code] }
      if index
        @items[index][:quantity] += item[:quantity]
      else
        @items << item
      end
    end
  end

  def check_stock(code:)
    item = items.find { |i| i[:code] == code }
    return false if item.nil?

    item[:quantity]
  end

  def check_price(code:)
    item = items.find { |i| i[:code] == code }
    return false if item.nil?

    item[:price]
  end

  private

  def decrement_stock(code:)
    index = items.find_index { |inv_item| inv_item[:code] == code }
    items[index][:quantity] -= 1
  end
end
