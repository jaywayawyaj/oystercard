class Oystercard
  attr_reader :balance, :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "£#{MAX_BALANCE} maximum balance exceeded." if max_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "Minimum journey balance required" unless @balance >= MIN_BALANCE
    @in_use = true
  end

  def in_journey?
    in_use
  end

  def touch_out
    @in_use = false
  end

  private

 def max_limit?(amount)
   amount + balance > MAX_BALANCE
 end

 MAX_BALANCE = 90
 MIN_BALANCE = 1

end
