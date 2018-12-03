require './lib/oystercard'

describe Oystercard do

  it "has a balance of zero" do
    expect(subject.balance).to eq(0)
  end

  it "the balance can be topped up" do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it "balance increased with #top_up" do
    subject.top_up(10)
    expect(subject.balance).to eql(10)
  end

end
