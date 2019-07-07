require './lib/inventory'

describe Inventory do
  let(:initial_stock) {
    [
      { name: 'Twix', price: 0.45, code: 'A1', quantity: 1 },
      { name: 'Buttons', code: 'A2', price: 0.95, quantity: 1 },
      { name: 'Soda', code: 'A3', price: 1.50, quantity: 1 },
      { name: 'Gum', code: 'A4', price: 0.35, quantity: 0 }
    ]
  }

  context '#load_items' do
    it 'adds supplied items to the inventory' do
      inventory = Inventory.new(items: initial_stock)
      new_stock = [
        { name: 'Swizzles', code: 'A5', price: 1.25, quantity: 2 },
        { name: 'Dip Dab', code: 'A6', price: 0.40, quantity: 2 },
        { name: 'Twix', price: 0.45, code: 'A1', quantity: 1 }
      ]

      inventory.load_items(items: new_stock)

      expect(inventory.items).to include new_stock.first
      expect(inventory.items).to include new_stock[1]
      two_twix_bars = { name: 'Twix', price: 0.45, code: 'A1', quantity: 2 }
      expect(inventory.items).to include(two_twix_bars)
    end
  end

  context '#vend' do
    it 'decreases its inventory when an item is sold' do
      inventory = Inventory.new(items: initial_stock)
      stock_code = 'A1'
      inventory.vend(code: stock_code)
      expect(inventory.check_stock(code: stock_code)).to eq 0
    end

    it 'returns the item selected item' do
      inventory = Inventory.new(items: initial_stock)
      stock_code = 'A3'
      expect(inventory.vend(code: stock_code)).to eq 'Soda'
    end
  end

  context '#check_price' do
    it 'returns the price of the item' do
      inventory = Inventory.new(items: initial_stock)
      stock_code = 'A1'
      expect(inventory.check_price(code: stock_code)).to eq 0.45
    end
  end
end
