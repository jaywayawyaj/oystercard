class Journey

  attr_reader :entry_station, :journey_history

  MIN_FARE = 2
  PENALTY_FARE = 6

  def initialize
    @entry_station = []
    @exit_station = []
    @journey_history = {}
  end

  def start(station)
    @entry_station << station
  end

  def in_journey?
    @entry_station.any?
  end

  def finish(station)

    @journey_history.store(entry_station.pop, station)
  end

  def fare
    journey_complete? ? MIN_FARE : PENALTY_FARE
  end

  def journey_complete?
  end

end
