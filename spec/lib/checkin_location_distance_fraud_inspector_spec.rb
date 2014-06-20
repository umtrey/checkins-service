require 'spec_helper'

describe CheckinLocationDistanceFraudInspector do
  it "returns false if there is no geolocation on the checkin" do
    checkin = create(:checkin, latitude: nil, longitude: nil)
    expect(CheckinLocationDistanceFraudInspector.inspect(checkin)).to be false
  end

  it "returns false if the geolocation on the checkin is 0, 0" do
    checkin = create(:checkin, latitude: 0, longitude: 0)
    expect(CheckinLocationDistanceFraudInspector.inspect(checkin)).to be false
  end

  it "returns false if the location does not have a geolocation" do
    location = create(:location, latitude: nil, longitude: nil)
    checkin = create(:checkin, location: location, latitude: 10, longitude: 10)
    expect(CheckinLocationDistanceFraudInspector.inspect(checkin)).to be false
  end

  it "returns true if the checkin is greater than a default distance from the location" do
    location = create(:location, latitude: 10, longitude: 10)
    checkin = create(:checkin, location: location,
                               latitude: 20, longitude: 20)

    expect(CheckinLocationDistanceFraudInspector.inspect(checkin)).to be true
  end

  it "returns false if the checkin is within a default distance from the location" do
    location = create(:location, latitude: 10, longitude: 10)
    checkin = create(:checkin, location: location,
                               latitude: 10, longitude: 10.0001)

    expect(CheckinLocationDistanceFraudInspector.inspect(checkin)).to be false
  end
end
