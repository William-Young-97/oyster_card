require 'journey'
require 'oystercard'

describe Journey do
 
  let(:entry_station) { double(:entry_station, zone: 1) }
  let(:exit_station) { double(:exit_station, zone: 2)}
  let(:oystercard) { double(:oystercard, balance: 0) }
  let(:topped_oyster) { double(:oystercard, balance: 2, deduct: 6) }
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

  it 'has a penalty fare by default' do
    expect(journey.fare).to eq(Journey::PENALTY_FARE)
  end

  context 'given an entry station' do
    it 'has an entry station' do
      expect(journey.entry_station).to eq(entry_station)
    end

    it "returns a penalty fare if no exit station given" do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    context 'given an exit station' do
      
      before do
        journey.finish(exit_station)
      end

      it 'calculates a fare' do
        p journey.journeys
        expect(journey.fare).to eq(1)
      end
    end
  end
end