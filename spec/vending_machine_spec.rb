require './lib/vending_machine'

describe VendingMachine do
  context '#new' do
    it 'loads an initial set coins (to make change)' do
      coins = [0.01, 0.02, 0.05, 0.10]
      vending_machine = VendingMachine.new(coins: coins)
      expect(vending_machine.coins_available).to eq coins
    end
  end
end
