require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :journey

  def initialize
    @journey = Journey.new
    @balance = 0
  end

  def top_up(amount)
    fail "£#{MAX_BALANCE} maximum balance exceeded." if max_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    #@journey.complete?(in) ? 
    raise "Minimum journey balance required" unless min_balance?
    @journey.start(station)
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @journey.finish(exit_station)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def min_balance?
    @balance >= MIN_BALANCE
  end

  def max_limit?(amount)
    amount + balance > MAX_BALANCE
  end

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 2

end
