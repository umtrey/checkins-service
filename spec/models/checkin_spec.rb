require 'spec_helper'

describe Checkin do
  let(:user)     { create(:user) }
  let(:location) { create(:location) }

  describe "validations" do
    it "should not create a checkin if no location provided" do
      expect(Checkin.new(user: user)).to_not be_valid
    end

    it "should not create a checkin if no user provideD" do
      expect(Checkin.new(location: location)).to_not be_valid
    end

    it "can take in a valid latitude and longitude" do
      expect(Checkin.new(checkin_params.merge(latitude: 0, longitude: 0))).to be_valid
    end

    it "requires latitude to be between -90 and 90" do
      expect(Checkin.new(checkin_params.merge(latitude: 100, longitude: 0))).to_not be_valid
      expect(Checkin.new(checkin_params.merge(latitude: -100, longitude: 0))).to_not be_valid
    end

    it "requires longitude to be between -180 and 180" do
      expect(Checkin.new(checkin_params.merge(latitude: 0, longitude: 190))).to_not be_valid
      expect(Checkin.new(checkin_params.merge(latitude: 0, longitude: -190))).to_not be_valid
    end

    it "requires both latitude and longitude to be given, if one is given" do
      expect(Checkin.new(checkin_params.merge(latitude: 0))).to_not be_valid
      expect(Checkin.new(checkin_params.merge(longitude: 0))).to_not be_valid
    end
  end

  describe "#time_since_last_checkin" do
    it "does not return nil if there has been a checkin for the user" do
      create(:checkin, user: user, location: location)
      expect(Checkin.time_since_last_checkin(user.id)).to_not be_nil
    end

    it "returns nil if there has not been a checkin for the user" do
      expect(Checkin.time_since_last_checkin(9000)).to be_nil
    end

    it "returns nil if the user id is invalid" do
      expect(Checkin.time_since_last_checkin(nil)).to be_nil
    end
  end

private
  def checkin_params
    { user: user,
      location: location }
  end
end
