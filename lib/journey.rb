class Journey

  attr_reader :entry_station, :journey_history

  def initialize(oyster=Oystercard.new)
    @entry_station = []
    @journey_history = {}
    @oyster = oyster
  end

  def start(station)
    @entry_station << station
  end

  def in_journey?
    entry_station.any?
  end

  def finish(station)
    @journey_history.store(entry_station.pop, station)
  end

end
