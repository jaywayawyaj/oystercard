class Journey

  attr_reader :entry_station, :exit_station, :journey_history

  MIN_FARE = 2
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def start(station)
    @entry_station = station
  end

  def in_journey?
    @entry_station != nil
  end

  def finish(station)
    @exit_station = station
    journey_log
  end

  def journey_log
    journey_history << {@entry_station => @exit_station}
  end

  def fare
    PENALTY_FARE unless complete?
    MIN_FARE
  end

  def complete?
    entry_station.nil? && exit_station.nil?
  end

end
