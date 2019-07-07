require './lib/vending_machine'
require './lib/inventory'

describe VendingMachine do
  let(:initial_coins) { [0.01, 0.02, 0.05, 0.10, 0.20, 0.50, 1.00, 2.00] }
  let(:inventory) { double('inventory') }
  let(:stock) {
    [
      { name: 'Twix', price: 0.45, code: 'A1', quantity: 1 },
      { name: 'Buttons', code: 'A2', price: 0.95, quantity: 1 },
      { name: 'Soda', code: 'A3', price: 1.50, quantity: 1 },
      { name: 'Gum', code: 'A4', price: 0.35, quantity: 0 }
    ]
  }

  context '#new' do
    it 'loads an initial set coins (to make change)' do
      vending_machine = VendingMachine.new(coins: initial_coins)
      expect(vending_machine.coins_available).to eq initial_coins
    end

    it 'loads an initial inventory of items' do
      allow(inventory).to receive_messages(
        items: stock
      )
      vending_machine = VendingMachine.new(inventory: inventory)
      expect(vending_machine.inventory.items).to eq stock
    end
  end

  context '#load_coins' do
    it 'adds supplied coins to the machine' do
      vending_machine = VendingMachine.new(coins: initial_coins)
      additional_coins = [0.20, 0.05]
      vending_machine.load_coins(coins: additional_coins)
      expected_coins = initial_coins.concat(additional_coins).sort
      expect(vending_machine.coins_available).to eq expected_coins
    end
  end

  context '#sell' do
    it 'dispenses the correct item and coins for change' do
      vending_machine = VendingMachine.new(inventory: inventory, coins: initial_coins)
      allow(inventory).to receive_messages(
        check_stock: 1,
        check_price: 0.95,
        vend: 'Buttons'
      )
      exp_result = { purchased: 'Buttons', change: [0.05, 1.00] }
      expect(vending_machine.sell(code: 'A2', coins: [2.00])).to eq exp_result
    end

    it 'asks for more money if the money inserted is not enough' do
      allow(inventory).to receive_messages(
        check_stock: 1,
        check_price: 0.45
      )
      vending_machine = VendingMachine.new(inventory: inventory)
      coins = [0.20, 0.20]
      expect(vending_machine.sell(code: 'A1', coins: coins)).to eq 'Insert more money, try again.'
    end

    it 'returns an error if the item entered does not exist/is out of stock' do
      vending_machine = VendingMachine.new(inventory: inventory)
      coins = [0.00]
      allow(inventory).to receive_messages(
        check_stock: 0
      )
      expect(vending_machine.sell(code: 'X1', coins: coins)).to eq 'Item not found.'
    end

    it 'returns no change when exact money is inserted' do
      purchased = { purchased: 'Twix', change: [] }
      allow(inventory).to receive_messages(
        check_stock: 1,
        check_price: 0.45,
        vend: 'Twix'
      )
      vending_machine = VendingMachine.new(inventory: inventory)
      expect(vending_machine.sell(code: 'A1', coins: [0.20, 0.20, 0.05])).to eq purchased
    end
  end
end
