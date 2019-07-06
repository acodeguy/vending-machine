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
end
