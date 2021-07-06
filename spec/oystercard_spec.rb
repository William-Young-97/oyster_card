require 'oystercard'

describe Oystercard do
  let(:balance) { subject.balance }
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE }
  let(:minimum) { Oystercard::MINIMUM }

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

  describe '#in_use?' do
    it 'Will return a false boolean if not in use.' do
    expect(subject.in_use).to eql(false)
    end
  end

  describe '#touch_in' do
    it 'Will cause in use to become true?' do
      subject.top_up(2)
      expect(subject.touch_in).to be(true)
    end

    it 'Will raise an error if touch_in with < £1' do
      expect{ subject.touch_in }.to raise_error "Require at least £#{minimum} to travel."
    end
  end

  describe '#touch_out' do
    it 'Will cause in use to become false.' do
      subject.in_use = true
      expect(subject.touch_out).to be(false)
    end

    it 'Will charge minimum fare you when you touch out' do
      expect{ subject.touch_out }.to change{ subject.balance }.by(-minimum)
    end

  end



end