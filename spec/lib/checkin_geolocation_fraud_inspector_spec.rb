require 'spec_helper'

describe CheckinGeolocationFraudInspector do
  it "returns true if no geolocation is provided in the checkin" do
    checkin = create(:checkin, latitude: nil, longitude: nil)
    expect(CheckinGeolocationFraudInspector.inspect(checkin)).to be true
  end

  it "returns true if the geolocation provided is 0N, 0E, as that's in the ocean" do
    checkin = create(:checkin, latitude: 0, longitude: 0)
    expect(CheckinGeolocationFraudInspector.inspect(checkin)).to be true
  end

  it "returns false if the geolocation is given" do
    checkin = create(:checkin, latitude: 41.8819, longitude: -87.6278)
    expect(CheckinGeolocationFraudInspector.inspect(checkin)).to be false
  end
end
