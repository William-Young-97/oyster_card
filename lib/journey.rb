require_relative 'oystercard'

class Journey
  PENALTY_FARE = 6
  attr_reader :entry_station, :oystercard, :journeys
  def initialize(entry_station=nil, oystercard)
    fail "£1 required for travel" if oystercard.balance < 1
    @oystercard = oystercard
    @entry_station = entry_station
    @exit_station = nil
    @journeys = [@entry_station, @exit_station]
    @zone_charges = {1 => 1, 2 => 1.50, 3 => 2, 4 => 2.50, 5 => 3}
  end

  def finish(exit_station)
    @exit_station = exit_station
    @journeys[1] = @exit_station
    fare
  end

  def fare
    diff = (@journeys[0].zone - @journeys[1].zone).abs
    @oystercard.deduct(@zone_charges[diff]) 
  end
end

# Journey should set in journey variable to true
# Can see when journey started
# Can see where journey ends
# Can calculate journey fair
# TDD this
