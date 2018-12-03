require './lib/oystercard'

describe Oystercard do

  it "has a balance" do
    expect(Oystercard.new).to respond_to(:balance)
  end

end
