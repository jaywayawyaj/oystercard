require 'oystercard'

describe Oystercard do
  let(:min_balance) {Oystercard::MIN_BALANCE}
  let(:max_balance) {Oystercard::MAX_BALANCE}
  let(:min_fare) {Oystercard::MIN_FARE}

  context '#balance' do

    it "has a balance of zero" do
     expect(subject.balance).to eq(0)
    end
  end

  context '#top_up' do

    it "the balance can be topped up" do
     expect(subject).to respond_to(:top_up).with(1).argument
    end

    it "balance increased with #top_up" do
     expect { subject.top_up(10) }.to change { subject.balance }.by 10
    end

    it 'raises an error if the maximum balance is exceeded' do
      subject.top_up(max_balance)
      expect{ subject.top_up 1 }.to raise_error "£#{max_balance} maximum balance exceeded."
    end
  end

  context 'journey' do
    let(:oyster) { Oystercard.new }
    let(:station) { double :station }
    let(:station_out) { double :station_out}
    context 'journey combos' do

      it 'expects subject to initialise as not in use' do
        expect(oyster).not_to be_in_journey
      end

      it '#touch_in and #touch_out creates one journey' do
        oyster.top_up(5)
        oyster.touch_in(station)
        oyster.touch_out(station_out)
        expect(oyster.journey_history).to eql([{station => station_out}])
      end
    end

    context '#touch_in' do

      it '#touch_in makes #in_journey true' do
        oyster.top_up(min_balance)
        oyster.touch_in(station)
        expect(oyster).to be_in_journey
      end

      it 'requires a minimum balance to touch in' do
        message = "Minimum journey balance required"
        expect { subject.touch_in(station) }.to raise_error message
      end

      it 'oyster remembers station after #touch_in' do
        oyster.top_up(min_balance)
        oyster.touch_in(station)
        expect(oyster.entry_station).to eq [station]
      end
    end

    context '#touch_out' do

      it '#touch_out makes #in_journey false' do
        allow(oyster).to receive(:touch_in).and_return(true)
        oyster.touch_out(station)
        expect(oyster).not_to be_in_journey
      end

      it '#touch_out charges oyster' do
        expect{ oyster.touch_out(station) }.to change{ oyster.balance }.by(-min_fare)
      end
    end
  end
end
