class Oystercard

  attr_reader :balance
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Your balance is already: £#{@balance}."\
    "This transaction would take over the £#{MAXIMUM_BALANCE} limit."\
    if (@balance+amount) > 90
    @balance += amount
  end
end