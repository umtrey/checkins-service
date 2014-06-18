require 'spec_helper'

def app
  ApplicationApi
end

describe CheckinsApi do
  include Rack::Test::Methods
  before(:all) do
    Checkin.create(user_id: 1, location_id: 2)
    Checkin.create(user_id: 1, location_id: 3)
    Checkin.create(user_id: 2, location_id: 3)
  end

  describe 'POST /checkins' do
    it 'creates a new checkin' do
      expect do
        post '/checkins', user_id: 1, location_id: 1
      end.to change{ Checkin.count }.by(1)
    end

    it "returns details of the newly created checkin" do
      post '/checkins', user_id: 2, location_id: 2
      json_response = JSON.parse(last_response.body)["data"]
      expect(json_response["id"]).to eq(Checkin.last.id)
      expect(json_response["user_id"]).to eq(2)
      expect(json_response["location_id"]).to eq(2)
      expect(json_response.keys).to include("created_at")
    end

    it "errors if not given a user_id" do
      expect do
        post '/checkins', location_id: 1
        expect(last_response.status).to eq(400)
      end.to_not change { Checkin.count }
    end
  end

  describe 'GET /checkins/user/:user_id' do
    it "returns all checkins for a given user id" do
      get '/checkins/user/1'
      expect(JSON.parse(last_response.body)["data"].count).to eq(Checkin.where(user_id: 1).count)
    end

    it "returns no checkins for a user that has not checked in anywhere" do
      get '/checkins/user/9000'
      expect(JSON.parse(last_response.body)["data"]).to be_empty
    end

    it "fails if not given a user id" do
      get '/checkins/user'
      expect(last_response.status).to eq(404)
    end
  end

  describe 'GET /checkins/location/:location_id' do
    it "returns all checkins for a given user id" do
      get '/checkins/location/3'
      expect(JSON.parse(last_response.body)["data"].count).to eq(Checkin.where(location_id: 3).count)
    end

    it "returns no checkins for a user that has not checked in anywhere" do
      get '/checkins/location/9000'
      expect(JSON.parse(last_response.body)["data"]).to be_empty
    end

    it "fails if not given a user id" do
      get '/checkins/location'
      expect(last_response.status).to eq(404)
    end
  end
end
