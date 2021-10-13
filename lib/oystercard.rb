class Oystercard
  
  INITIAL_BALANCE = 0
  MAX_BALANCE = 90
  attr_reader :balance

  def initialize
    @balance = INITIAL_BALANCE
  end
  
  def top_up(amount)
    @balance += amount
    fail "Cannot exceed £90" if maximum_limit
  end

  private

  def maximum_limit
    @balance > MAX_BALANCE
  end

end