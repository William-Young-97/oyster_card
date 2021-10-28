require 'journey'
require 'oystercard'

describe Journey do
 
  let(:entry_station) { double(:entry_station, zone: 1) }
  let(:oystercard) { double(:oystercard, balance: 0) }
  let(:topped_oyster) { double(:oystercard, balance: 2) }
  let(:journey) { Journey.new(entry_station, topped_oyster) }

  it 'Raises an error if not at least £1 on card' do
    expect{Journey.new(entry_station, oystercard)}.to raise_error("£1 required for travel")
  end
  
  it 'Saves your current station' do
    journey
    expect(journey.entry_station).to eq(entry_station) 
  end

  it "knows if a journey is not complete" do
    journey
    expect(journey.journeys).to eq([entry_station, nil])
  end

  # it 'has a penalty fare by default' do
  #   expect(subject.fare).to eq Journey::PENALTY_FARE
  # end

  # it "returns itself when exiting a journey" do
  #   expect(subject.finish(station)).to eq(subject)
  # end

  # context 'given an entry station' do
  #   subject {described_class.new(entry_station: station)}

  #   it 'has an entry station' do
  #     expect(subject.entry_station).to eq station
  #   end

  #   it "returns a penalty fare if no exit station given" do
  #     expect(subject.fare).to eq Journey::PENALTY_FARE
  #   end

  #   context 'given an exit station' do
  #     let(:other_station) { double :other_station }

  #     before do
  #       subject.finish(other_station)
  #     end

  #     it 'calculates a fare' do
  #       expect(subject.fare).to eq 1
  #     end

  #     it "knows if a journey is complete" do
  #       expect(subject).to be_complete
  #     end
  #   end
  # end
end