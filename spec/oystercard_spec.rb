require 'oystercard'

describe Oystercard do
  it "can show balance" do
    oystercard = Oystercard.new
   expect(oystercard.balance).to eq 0
  end

  it "top up balance" do
    oystercard = Oystercard.new
    oystercard.top_up(10)
    expect(oystercard.balance).to eq 10 
  end

  it "can go overlimit" do
    oystercard = Oystercard.new
    expect{oystercard.top_up(100)}.to raise_error "Overlimit: Limit is £90"
  end


  it "can touch-in" do
    oystercard = Oystercard.new
    oystercard.top_up(20)
    oystercard.touch_in
    expect(oystercard.in_journey?).to eq true
  end

  it "can touch-out" do
    oystercard = Oystercard.new
    oystercard.top_up(20)
    oystercard.touch_in
    oystercard.touch_out
    expect(oystercard.in_journey?).to eq false
  end

  it "should have minimum balance" do
    oystercard = Oystercard.new
    expect{oystercard.touch_in}.to raise_error "No balance: Minimum £1"
  end

  it "correct amount deducted from my card" do
    oystercard = Oystercard.new
    oystercard.top_up(20)
    oystercard.touch_in
    expect {oystercard.touch_out}.to change{oystercard.balance}.by(-1)
  end
end