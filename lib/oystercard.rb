require "journey"

class Oystercard
  attr_reader :balance, :entry_station, :journeys
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    @balance += amount
    raise "Maximum balance reached" if @balance > MAXIMUM_BALANCE
  end

  private  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(entry_station)
    raise "Insufficient funds." if @balance < MINIMUM_FARE
    @entry_station = entry_station
    new_journey = Journey.new
    new_journey.start_journey(entry_station)
    if @journeys[-1].is_complete? == true
      @journeys.push(new_journey)
    else
      @journeys[-1].calc_fare
      @journeys.push(new_journey)
    end
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    if @journeys[-1].is_complete? == false
      @journeys[-1].calc_fare
      @journeys[-1].end_journey(exit_station)
    else
      @journeys[-1].calc_fare
      new_journey = Journey.new
      new_journey.end_journey(exit_station)
      @journeys.push(new_journey)
    end
    @entry_station = nil
    
  end


end

