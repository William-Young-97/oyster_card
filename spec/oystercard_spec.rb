require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it "Shows current balance" do
      expect(subject.balance).to eq(5)
    end
  end
end
