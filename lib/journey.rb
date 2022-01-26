class Journey
  attr_reader :entry_station, :exit_station
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
  end

  def is_complete?
    @entry_station != nil && @exit_station != nil
  end

  def calc_fare
    is_complete? ? MINIMUM_FARE : PENALTY_FARE
#    if is_complete?
#      return MINIMUM_FARE
#    else
#      return PENALTY_FARE
#    end
  end

end