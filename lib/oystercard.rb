class Oystercard

attr_reader :bal

    def initialize
        @bal = 0
    end

    def top_up(amt)
        @bal += amt
    end

end