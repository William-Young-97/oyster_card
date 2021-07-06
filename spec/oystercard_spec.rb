require 'oystercard'

describe Oystercard do
  let(:balance) { subject.balance }
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE }
  let(:minimum) { Oystercard::MINIMUM }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it 'Creates an instance of Oystercard' do
    expect(subject).to be_instance_of(Oystercard)
  end

  it 'Card has default balance zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do

    it 'Card responds to top_up' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'top_up will add to balance' do
      expect{ subject.top_up(1) }.to change{ subject.balance }.by(1)
    end
    
    it 'Raises error if attempting to add more than £90 limit' do
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error "Your balance is already: £#{balance}."\
       "This transaction would take over the £#{maximum_balance} limit."\
    end
  end

  describe '#deduct' do
    it 'Will deduct a given amount' do
      expect{ subject.send(:deduct, 1) }.to change{ subject.balance }.by(-1)
    end
  end

  describe '#journey' do
    it 'Will return a false boolean if card not in use.' do
    expect(subject.journey).to eql(nil)
    end
  end

  describe '#touch_in' do
    
    it 'Will cause in use to become true?' do
      subject.top_up(5)
      expect(subject.touch_in(entry_station)).to be(entry_station)
    end

    it 'Will raise an error if touch_in with < £1' do
      expect{ subject.touch_in(entry_station) }.to raise_error "Require at least £#{minimum} to travel."
    end

    it 'Expect touch in to pass 1 arg' do
      expect(subject).to respond_to(:touch_in).with(1).argument
    end

    it 'Will store entry station' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end
  end

  describe '#touch_out' do
    it 'Will cause in use to become nil.' do
      subject.top_up(5)
      expect(subject.touch_out(exit_station)).to be(nil)
    end

    it 'Will charge minimum fare you when you touch out' do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-minimum)
    end

    it 'Expects touch out to set entry station to nil' do
      subject.top_up(5)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eql(nil)
    end

    it 'Will accept an argument' do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end

    it 'Will store journeys upon touch out' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_history).to include(entry_station => exit_station)
    end 
  end
    it 'Will expect card journeys to be empty by default' do
      expect(subject.journey_history).to eq([])
    end
end