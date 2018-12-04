require 'station'

decribe 'Station' do
  
  it 'initializes with custom station' do
    expect(name.zoningmethod).to eql(zone)
  end

  it 'initializes with custom zone' do
    expect(name.zoningmethod).to eql(zone)
  end
end
