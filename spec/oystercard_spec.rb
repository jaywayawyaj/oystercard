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
    expect { subject.top_up(10) }.to change { oyster.balance }. by 10
  end

  it "has a balance limit of 90" do
    message = "Error: cannot exceed £90 limit"
    expect { oyster.top_up(91) }.to eq message
  end
end
