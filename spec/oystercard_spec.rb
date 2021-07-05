require 'oystercard'

describe Oystercard do
    it 'Creates an instance of Oystercard' do
        expect(subject).to be_instance_of(Oystercard)
    end
    it 'Card has default balance zero' do
        expect(subject.bal).to eq(0)
    end
end