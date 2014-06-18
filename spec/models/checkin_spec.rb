require 'spec_helper'

describe Checkin do
  before(:all) do
    Checkin.create(user_id: 1, location_id: 1)
  end

  describe "#time_since_last_checkin" do
    it "does not return nil if there has been a checkin for the user" do
      expect(Checkin.time_since_last_checkin(1)).to_not be_nil
    end

    it "returns nil if there has not been a checkin for the user" do
      expect(Checkin.time_since_last_checkin(9000)).to be_nil
    end

    it "returns nil if the user id is invalid" do
      expect(Checkin.time_since_last_checkin(nil)).to be_nil
    end
  end
end
