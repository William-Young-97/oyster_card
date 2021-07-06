class Oystercard
  
  attr_reader :balance, :entry_station, :journey_history
  MAXIMUM_BALANCE = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @entry_station
    @journey_history = []
  end

  def top_up(amount)
    fail "Your balance is already: £#{@balance}."\
     "This transaction would take over the £#{MAXIMUM_BALANCE} limit."\
    if (@balance+amount) > 90
    @balance += amount
  end

  def journey
    @entry_station
  end
  
  def touch_in(entry_station)
    fail "Require at least £#{MINIMUM} to travel." if @balance < 1
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM)
    @exit_station = exit_station
    history
    @entry_station = nil
  end

  def history
    @journey_history << { @entry_station => @exit_station }
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end