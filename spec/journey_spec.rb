require 'journey'

describe Journey do
  let(:oyster) { double :oyster, balance: 10 }
  let(:station) { double :station }
  let(:station_out) { double :station_out }
  let(:journey) { Journey.new }

  context 'journey combos' do
    it 'expects subject to initialise as not in use' do
      expect(journey).not_to be_in_journey
    end

    it '#start and #finish creates one journey' do
      journey.start(station)
      journey.finish(station_out)
      expect(journey.journey_history).to eql([{station => station_out}])
    end
  end

  context '#start' do

    it '#start makes #in_journey true' do
      journey.start(station)
      expect(journey).to be_in_journey
    end

    it 'journey remembers station after #start' do
      journey.start(station)
      expect(journey.entry_station).to eq station
    end
  end

  context '#finish' do

    it '#finish makes #in_journey false' do
      allow(journey).to receive(:start).and_return(true)
      journey.finish(station)
      expect(journey).not_to be_in_journey
    end
  end
  it "returns a penalty fare if no exit station given" do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end
end
