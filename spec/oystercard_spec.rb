require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it "Shows current balance" do
      expect(subject.balance).to eq(Oystercard::INITIAL_BALANCE)
    end
  end

  describe '#top_up' do
    it 'Allows you to add to your balance' do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end
    it 'Raises an error if adding over £90 total' do
      subject.top_up(Oystercard::MAX_BALANCE)
      expect{subject.top_up(1)}.to raise_error("Cannot exceed £90")
    end
  end
end
