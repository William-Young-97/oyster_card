class Oystercard
  
  attr_reader :balance
  attr_accessor :in_use
  MAXIMUM_BALANCE = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "Your balance is already: £#{@balance}."\
     "This transaction would take over the £#{MAXIMUM_BALANCE} limit."\
    if (@balance+amount) > 90
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
  
  def touch_in
    fail "Require at least £#{MINIMUM} to travel." if @balance < 1
    @in_use = true
  end

  def touch_out
    @in_use = false
  end
end