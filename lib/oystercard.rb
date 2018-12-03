class Oystercard

  attr_reader :balance, :in_use
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "#{MAXIMUM_BALANCE} exceeded." if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_use = true
  end

  def in_journey?
    in_use
  end

  def touch_out
    @in_use = false
  end

end
