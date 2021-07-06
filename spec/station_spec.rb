require 'station'

describe Station do
  describe '#initialization' do
    let(:station) {Station.new("Abbey Wood", 5)}

  it 'Station has a name' do
    expect(station.name).to eq("Abbey Wood")
  end

  it 'Station has a zone' do
    expect(station.zone).to eq(5)
  end
 end 
end