require 'oystercard'

describe Oystercard do
  let(:min_balance) { Oystercard::MIN_BALANCE }
  let(:max_balance) { Oystercard::MAX_BALANCE }
  let(:min_fare) { 2 }

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

    context '#touch_in' do

      it 'requires a minimum balance to touch in' do
        message = "Minimum journey balance required"
        expect { subject.touch_in(station) }.to raise_error message
      end
    end

    context '#touch_out' do

      it '#touch_out charges oyster minimum fare' do
        expect{ oyster.touch_out(station) }.to change{ oyster.balance }.by(-min_fare)
      end
    end

    it "deducts penalty fare if two touch in's with no exit" do
      fare = double(:fare)
      oyster.top_up(20)
      expect { 2.times { oyster.touch_in(station) } }.to change { oyster.balance }.by -6
    end
  end
end
