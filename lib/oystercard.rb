require_relative 'journey'
require_relative 'station'
class Oystercard
  
  INITIAL_BALANCE = 0
  MAX_BALANCE = 90
  MIN_AMOUNT = 1
  MIN_FARE = 2
  attr_reader :balance, :journeys

  def initialize
    @balance = INITIAL_BALANCE
  end
  
  def top_up(amount)
    fail "Cannot exceed £90" if maximum_limit(amount)
    @balance += amount
  end
  
  def deduct(amount=MIN_FARE)
    (@balance -= amount)
  end

  private

  def maximum_limit(amount)
    (amount + @balance) > MAX_BALANCE
  end

  def minimum_limit
    @balance < MIN_AMOUNT
  end
end