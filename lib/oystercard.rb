class Oystercard
  
  INITIAL_BALANCE = 0
  MAX_BALANCE = 90
  MIN_AMOUNT = 1
  MIN_FARE = 2
  attr_reader :balance, :in_journey, :journeys

  def initialize
    @balance = INITIAL_BALANCE
    @in_journey = false
    @journeys = []
    @counter = 0
  end
  
  def top_up(amount)
    fail "Cannot exceed £90" if maximum_limit(amount)
    @balance += amount
  end
  
  def touch_in(entry_station)
    fail "£1 required for travel" if minimum_limit
    @in_journey = true
    station_pusher(entry_station)
  end

  def touch_out(exit_station)
    @in_journey = false
    deduct
    @journeys[@counter] = {nil => exit_station}
    @counter += 1
  end

  private

  def deduct(amount=MIN_FARE)
    (@balance -= amount)
  end

  def maximum_limit(amount)
    (amount + @balance) > MAX_BALANCE
  end

  def minimum_limit
    @balance < MIN_AMOUNT
  end

  def station_pusher(entry_station)
    stations = {entry_station => nil}
    @journeys << stations
  end
end