require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6
  attr_reader :entry_station, :oystercard, :journeys

  def initialize(entry_station=nil, oystercard)
    fail "£1 required for travel" if min_guard(oystercard)
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
    @journeys.include?(nil) ? penalty : calculate_zone_charge
  end

  private

  def min_guard(oystercard)
    oystercard.balance < Oystercard::MIN_AMOUNT 
  end

  def penalty
    @oystercard.deduct(PENALTY_FARE) 
  end

  def calculate_zone_charge
    diff = (@journeys[0].zone - @journeys[1].zone).abs
    @oystercard.deduct(@zone_charges[diff]) 
    @zone_charges[diff]
  end
end
