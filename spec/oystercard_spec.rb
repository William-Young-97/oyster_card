require 'oystercard'

describe Oystercard do
  let(:entry_station) {double(:entry_station)}
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
    it 'Deducts money from card once journey is complete' do
      subject.top_up(Oystercard::MIN_FARE)
      expect{ subject.touch_out }.to change{ subject.balance }.from(2).to(0)
    end
  end

  describe '#touch_in' do
    it 'Sets in_journey status to true' do
      subject.top_up(Oystercard::MIN_AMOUNT)
      subject.touch_in(entry_station)
      expect(subject.in_journey).to be true
    end
    it 'Raises an error if not at least £1 on card' do
      expect{subject.touch_in(entry_station)}.to raise_error("£1 required for travel")
    end
    it 'Saves your current station' do
      subject.top_up(Oystercard::MIN_AMOUNT)
      p subject.touch_in(entry_station)
      p @stations
      expect(subject.stations).to eq([entry_station]) 
    end
  end

  describe '#touch_out' do
    it 'Sets in_journey status to false' do
      subject.touch_out
      expect(subject.in_journey).to be false
    end
  end
end
