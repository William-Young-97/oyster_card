class Oystercard
  
  INITIAL_BALANCE = 0
  MAX_BALANCE = 90
  attr_reader :balance, :in_journey

  def initialize
    @balance = INITIAL_BALANCE
    @in_journey = false
  end
  
  def top_up(amount)
    fail "Cannot exceed £90" if maximum_limit(amount)
    @balance += amount
  end

  def deduct(amount)
    (@balance -= amount)
  end
  
  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def maximum_limit(amount)
    (amount + @balance) > MAX_BALANCE
  end
end