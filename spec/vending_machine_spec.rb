require './lib/vending_machine'

describe VendingMachine do
  context '#new' do
    it 'loads an initial set coins (to make change)' do
      coins = [0.01, 0.02, 0.05, 0.10]
      vending_machine = VendingMachine.new(coins: coins)
      expect(vending_machine.coins_available).to eq coins
    end

    it 'loads an initial inventory of items' do
      inventory = [
        { name: 'Twix', price: 0.45, code: 'A1', quantity: 1 },
        { name: 'Buttons', code: 'A2', price: 0.95, quantity: 1 },
        { name: 'Soda', code: 'A3', price: 1.50, quantity: 1 },
        { name: 'Gum', code: 'A4', price: 0.35, quantity: 0 }
      ]
      vending_machine = VendingMachine.new(inventory: inventory)
      expect(vending_machine.inventory).to eq inventory
    end
  end

  context '#load_coins' do
    it 'adds supplied coins to the machine' do
      initial_coins = [0.01, 0.01, 0.01]
      vending_machine = VendingMachine.new(coins: initial_coins)
      additional_coins = [0.20, 0.05]
      vending_machine.load_coins(coins: additional_coins)
      expected_coins = initial_coins.concat(additional_coins).sort
      expect(vending_machine.coins_available).to eq expected_coins
    end
  end

  context '#load_items' do
    it 'adds supplied items to its inventory' do
      inventory = [
        { name: 'Twix', price: 0.45, code: 'A1', quantity: 1 },
        { name: 'Buttons', code: 'A2', price: 0.95, quantity: 1 },
        { name: 'Soda', code: 'A3', price: 1.50, quantity: 1 },
        { name: 'Gum', code: 'A4', price: 0.35, quantity: 0 }
      ]
      vending_machine = VendingMachine.new(inventory: inventory)
      new_stock = [
        { name: 'Swizzles', code: 'A5', price: 1.25, quantity: 2 },
        { name: 'Dip Dab', code: 'A6', price: 0.40, quantity: 2 },
        { name: 'Twix', price: 0.45, code: 'A1', quantity: 1 }
      ]
      vending_machine.load_items(items: new_stock)
      expect(vending_machine.inventory).to include new_stock.first
      expect(vending_machine.inventory).to include new_stock[1]
      two_twix_bars = { name: 'Twix', price: 0.45, code: 'A1', quantity: 2 }
      expect(vending_machine.inventory).to include(two_twix_bars)
    end
  end

  context '#sell' do
    it 'dispenses the correct item and coins for change' do
      inventory = [
        { name: 'Twix', price: 0.45, code: 'A1', quantity: 1 },
        { name: 'Buttons', code: 'A2', price: 0.95, quantity: 1 },
        { name: 'Soda', code: 'A3', price: 1.50, quantity: 1 },
        { name: 'Gum', code: 'A4', price: 0.35, quantity: 0 }
      ]
      coins = [0.01, 0.02, 0.05, 0.10, 0.20, 0.50, 1.00, 2.00]
      vending_machine = VendingMachine.new(inventory: inventory, coins: coins)
      exp_result = { purchased: 'Buttons', change: [0.05, 1.00] }
      expect(vending_machine.sell(code: 'A2', coins: [2.00])).to eq exp_result
    end
  end
end
