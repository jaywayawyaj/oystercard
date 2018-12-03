require './lib/oystercard'

describe Oystercard do

  let(:oyster) { Oystercard.new }

  it "has a balance of zero" do
   expect(subject.balance).to eq(0)
  end

  it "the balance can be topped up" do
   expect(subject).to respond_to(:top_up).with(1).argument
  end

  it "balance increased with #top_up" do
   expect { subject.top_up(10) }.to change { subject.balance }. by 10
  end


  it 'raises an error if the maximum balance is exceeded' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    expect{ subject.top_up 1 }.to raise_error "#{maximum_balance} exceeded."
  end

  it 'responds to #deduct' do
    expect(subject).to respond_to(:deduct).with(1).argument
  end

  it '#deduct reduces balance' do
    expect { subject.deduct(10) }.to change { subject.balance }. by -10
  end

  context 'journey'do
    it 'responds to #touch_in' do
      expect(subject).to respond_to(:touch_in)
    end

    it '#touch_in makes #in_journey true' do
      expect{ subject.touch_in }.to change { subject.in_journey? }.to eq true
    end

    it '#touch_out makes #in_journey false' do
      subject.touch_in
      expect{ subject.touch_out }.to change { subject.in_journey? }.to eq false
    end
  end
end
