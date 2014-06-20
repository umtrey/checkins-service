require 'spec_helper'

def app
  ApplicationApi
end

describe CheckinsApi do
  include Rack::Test::Methods

  describe 'POST /checkins' do
    let(:user) { create(:user) }
    let(:location) { create(:location) }

    it 'creates a new checkin' do
      expect do
        post '/checkins', user_id: user.id, location_id: location.id
      end.to change{ Checkin.count }.by(1)
    end

    it "returns details of the newly created checkin" do
      post '/checkins', user_id: user.id, location_id: location.id
      json_response = JSON.parse(last_response.body)["data"]
      expect(json_response["id"]).to eq(Checkin.last.id)
      expect(json_response["user_id"]).to eq(user.id)
      expect(json_response["location_id"]).to eq(location.id)
      expect(json_response.keys).to include("created_at")
    end

    it "errors if not given a user_id" do
      expect do
        post '/checkins', user_id: user.id
        expect(last_response.status).to eq(400)
      end.to_not change { Checkin.count }
    end

    it "errors if not given a location_id" do
      expect do
        post '/checkins', location_id: location.id
        expect(last_response.status).to eq(400)
      end.to_not change { Checkin.count }
    end

    it "errors if given an invalid user_id" do
      expect do
        post '/checkins', user_id: 9000, location_id: location.id
        expect(last_response.status).to eq(500)
      end.to_not change { Checkin.count }
    end

    it "errors if given an invalid location_id" do
      expect do
        post '/checkins', user_id: user.id, location_id: 9000
        expect(last_response.status).to eq(500)
      end.to_not change { Checkin.count }
    end
  end

  describe "object-related GET methods" do
    before(:all) do
      @user1 = create(:user)
      @location1 = create(:location)
      create(:checkin, user: @user1, location: @location1)
      create(:checkin, user: @user1)
      create(:checkin)
    end

    describe 'GET /checkins/user/:user_id' do
      it "returns all checkins for a given user id" do
        get "/checkins/user/#{ @user1.id }"
        expect(JSON.parse(last_response.body)["data"].count).to eq(2)
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
        get "/checkins/location/#{ @location1.id }"
        expect(JSON.parse(last_response.body)["data"].count).to eq(1)
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
end
