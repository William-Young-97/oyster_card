require 'station'

describe Station do
  let(:station) {double(:station, name: "Abbey Wood", zone: 5)}
  it 'Intializes with a name' do
    expect(station.name).to eq("Abbey Wood") 
  end
  it 'Intializes with a zone' do
    expect(station.zone).to eq(5) 
  end
end