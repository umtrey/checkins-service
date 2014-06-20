require 'spec_helper'

describe CheckinProximityFraudInspector do
  it "returns false if the checkin does not have a geolocation" do
    checkin = create(:checkin, latitude: nil, longitude: nil)
    expect(CheckinProximityFraudInspector.inspect(checkin)).to be false
  end

  it "returns false if the checkin is located at 0, 0" do
    checkin = create(:checkin, latitude: 0, longitude: 0)
    expect(CheckinProximityFraudInspector.inspect(checkin)).to be false
  end

  it "returns false if there have been no previous checkins for the user" do
    user = create(:user)
    checkin = create(:checkin, user: user, latitude: 10, longitude: 10)
    expect(CheckinProximityFraudInspector.inspect(checkin)).to be false
  end

  it "returns false if there have been no previous checkins for the user in the past hour" do
    user = create(:user)
    create(:checkin, user: user, latitude: 10, longitude: 10, created_at: Time.now - 61.minute)
    create(:checkin, latitude: 10, longitude: 10, created_at: Time.now - 1.minute)
    checkin = create(:checkin, user: user, latitude: 40, longitude: 40)
    expect(CheckinProximityFraudInspector.inspect(checkin)).to be false
  end

  it "returns true if the previous checkin traveled too far too quickly" do
    user = create(:user)
    checkin1 = create(:checkin, user: user, latitude: 10, longitude: 10, created_at: Time.now - 1.minute)
    checkin2 = create(:checkin, user: user, latitude: 40, longitude: 40)
    expect(CheckinProximityFraudInspector.inspect(checkin1)).to be false
    expect(CheckinProximityFraudInspector.inspect(checkin2)).to be true
  end

  it "returns true if total distance traveled over time is over threshold" do
    # checkin1 -> checkin2 = 54.75
    # checkin2 -> checkin3 = 123.9
    user = create(:user)
    checkin1 = create(:checkin, user: user, latitude: 10, longitude: 10, created_at: Time.now - 58.minute)
    checkin2 = create(:checkin, user: user, latitude: 10, longitude: 10.5, created_at: Time.now - 30.minute)
    checkin3 = create(:checkin, user: user, latitude: 11, longitude: 11)

    expect(CheckinProximityFraudInspector.inspect(checkin1)).to be false
    expect(CheckinProximityFraudInspector.inspect(checkin2)).to be false
    expect(CheckinProximityFraudInspector.inspect(checkin3)).to be true
  end
end
