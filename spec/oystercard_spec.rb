require './lib/oystercard'

describe Oystercard do

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
     expect { subject.top_up(10) }.to change { subject.balance }. by 10
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAX_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1 }.to raise_error "£#{maximum_balance} maximum balance exceeded."
    end
  end

  context '#deduct' do

    it 'responds to #deduct' do
      expect(subject).to respond_to(:deduct).with(1).argument
    end

    it '#deduct reduces balance' do
      expect { subject.deduct(10) }.to change { subject.balance }. by -10
    end
  end

  context 'journey' do

    let(:oyster) { Oystercard.new }
    it 'expects subject to initialise as not in use' do
      expect(subject).not_to be_in_journey
    end

    it 'requires a minimum balance to touch in' do
      message = "Minimum journey balance required"
      expect { subject.touch_in }.to raise_error message
    end

    it '#touch_in makes #in_journey true' do
      oyster.top_up(Oystercard::MIN_BALANCE)
      oyster.touch_in
      expect(oyster).to be_in_journey
    end

    it '#touch_out makes #in_journey false' do
      allow(subject).to receive(:touch_in).and_return(true)
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end
