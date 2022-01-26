require 'Oystercard'

describe Oystercard do
  let(:station) { double :station }
  it 'checks that the card has a balance' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'allows the card to be topped-up' do
      expect { subject.top_up(5) }.to change{ subject.balance }.by 5
    end

    it 'returns an error if the new balance is over the limit' do
      expect { subject.top_up(100) }.to raise_error( "Maximum balance reached")
    end
  end

  it 'checks for in_journey? to be false' do
    subject.touch_out(station)
    expect(subject.in_journey?).to eq false
  end

  it 'returns an error if card does not have sufficient balance' do
    expect { subject.touch_in(station)}.to raise_error("Insufficient funds.")
  end

  it 'deducts the fare after travel' do
    expect { subject.touch_out(station) }.to change { subject.balance }.by -1
  end

  it 'touching in records the station' do
    subject.top_up(5)
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end

  it 'card has empty journey hash' do
    expect(subject.journeys).to be_empty
  end

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  it 'touching out stores the journey in journeys' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to include entry_station
  end

end

