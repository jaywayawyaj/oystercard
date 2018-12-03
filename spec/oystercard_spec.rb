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
    expect{ subject.top_up 1 }.to raise_error 'Maximum balance exceeded'
  end


end
