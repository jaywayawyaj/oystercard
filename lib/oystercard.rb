class Oystercard
  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = []
  end

  def top_up(amount)
    fail "£#{MAX_BALANCE} maximum balance exceeded." if max_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Minimum journey balance required" unless @balance >= MIN_BALANCE
    @in_use = true
    entry_station << station
  end

  def in_journey?
    return false if entry_station == []
    true
  end

  def touch_out
    @in_use = false
    deduct(MIN_FARE)
    entry_station.pop
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def max_limit?(amount)
    amount + balance > MAX_BALANCE
  end

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 2

end
