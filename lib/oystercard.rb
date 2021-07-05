class Oystercard

attr_reader :bal
MAXIMUM_BALANCE = 90

    def initialize
        @bal = 0
    end

    def top_up(amt)
        fail "Your balance is already: £#{@bal}. This transaction would take over the £#{MAXIMUM_BALANCE} limit." if (@bal+amt) > 90
        @bal += amt
    end

end