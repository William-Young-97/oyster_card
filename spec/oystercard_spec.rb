require 'oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }
  let(:entry_station) {double(:entry_station, zone: 1)}
  let(:exit_station) {double(:exit_station, zone: 4)}
  let(:journey) {Journey.new(entry_station, oystercard)}
  describe '#balance' do
    it "Shows current balance" do
      expect(oystercard.balance).to eq(Oystercard::INITIAL_BALANCE)
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
      oystercard.top_up(Oystercard::MIN_FARE)
      journey
      expect{ journey.finish(exit_station) }.to change{ oystercard.balance }.from(2).to(0)
    end
  end
end
