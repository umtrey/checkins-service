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
end
