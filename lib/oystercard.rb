class Oystercard

  attr_reader :balance
  BALANCE_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    "Error: cannot exceed £90 limit"
    @balance += amount
  end

end
