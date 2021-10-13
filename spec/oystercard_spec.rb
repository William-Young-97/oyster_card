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

  describe '#deduct' do
    it 'Deducts a specific amount from the balance' do
      subject.top_up(50)
      expect(subject.deduct(49)).to eq(1)
    end
  end

  describe '#touch_in' do
    it 'Sets in_journey status to true' do
      subject.top_up(Oystercard::MIN_AMOUNT)
      expect(subject.touch_in).to be true
    end
    it 'Raises an error if not at least £1 on card' do
      expect{subject.touch_in}.to raise_error("£1 required for travel")
    end
  end

  describe '#touch_out' do
    it 'Sets in_journey status to false' do
      expect(subject.touch_out).to be false
    end
  end
end
