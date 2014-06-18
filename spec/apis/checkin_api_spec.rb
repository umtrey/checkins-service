require 'spec_helper'

def app
  ApplicationApi
end

describe CheckinsApi do
  include Rack::Test::Methods

  describe 'POST /checkins' do
    it 'creates a new checkin' do
      expect do
        post '/checkins', user_id: 1, location_id: 1
      end.to change{ Checkin.count }.by(1)
    end

    it "returns details of the newly created checkin" do
      post '/checkins', user_id: 1, location_id: 1
      json_response = JSON.parse(last_response.body)["data"]
      expect(json_response["id"]).to eq(Checkin.last.id)
      expect(json_response["user_id"]).to eq(1)
      expect(json_response["location_id"]).to eq(1)
      expect(json_response.keys).to include("created_at")
    end

    it "errors if not given a user_id" do
      expect do
        post '/checkins', location_id: 1
        expect(last_response.status).to eq(400)
      end.to_not change { Checkin.count }
    end
  end
end
