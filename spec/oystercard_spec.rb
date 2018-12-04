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

    it 'expects subject to initialise as not in use' do
      expect(subject).not_to be_in_journey
    end

    it 'requires a minimum balance to touch in' do
      message = "Minimum journey balance required"
      expect { subject.touch_in(station) }.to raise_error message
    end

    it '#touch_in makes #in_journey true' do
      oyster.top_up(min_balance)
      oyster.touch_in(station)
      expect(oyster).to be_in_journey
    end

    it '#touch_out makes #in_journey false' do
      allow(subject).to receive(:touch_in).and_return(true)
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it '#touch_out charges oyster' do
      expect{ subject.touch_out }.to change{ subject.balance }.by(-min_fare)
    end

    it 'oyster remembers station after #touch_in' do
      subject.top_up(min_balance)
      subject.touch_in(station)
      expect(subject.entry_station).to eq [station]
    end
  end
end
