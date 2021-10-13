require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it "Shows current balance" do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'Allows you to add to your balance' do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end
  end
end
