require "journey"

describe Journey do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }


  it "can set an entry station" do
    subject.start_journey(entry_station)
    expect(subject.entry_station).to eq entry_station
  end

  it "can set an exit station" do
    subject.end_journey(exit_station)
    expect(subject.exit_station).to eq exit_station
  end

  it "check if journey is not complete" do
    subject.start_journey(entry_station)
    expect(subject.is_complete?).to eq false
  end

  it "check if journey was completed" do
    subject.start_journey(entry_station)
    subject.end_journey(exit_station)
    expect(subject.is_complete?).to eq true
  end

  it "return minimum fare for complete journey" do
    subject.start_journey(entry_station)
    subject.end_journey(exit_station)
    expect(subject.calc_fare).to eq 1
  end

  it "returns penalty for incomplete journey" do
    subject.start_journey(entry_station)
    expect(subject.calc_fare).to eq 6
  end

end