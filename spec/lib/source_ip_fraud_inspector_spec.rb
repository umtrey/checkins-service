require 'spec_helper'

describe SourceIpFraudInspector do
  it "returns true if source of checkin is nil" do
    checkin = create(:checkin)
    expect(SourceIpFraudInspector.inspect(checkin)).to be true
  end

  it "returns true if the source of checkin is blank" do
    checkin = create(:checkin, source: "")
    expect(SourceIpFraudInspector.inspect(checkin)).to be true
  end

  it "returns false if there is a source for the checkin" do
    checkin = create(:checkin, source: "127.0.0.1")
    expect(SourceIpFraudInspector.inspect(checkin)).to be false
  end
end
