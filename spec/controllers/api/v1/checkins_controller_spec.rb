require 'spec_helper'

describe Api::V1::CheckinsController do
 
  before(:all) do
    User.from_omniauth(OmniAuth.config.mock_auth[:twitter])
  end

  it "index should respond successful" do
    get :index, format: :json
    expect(response.status).to eq 200
  end

  it 'index should respond with all checkins' do
    Checkin.create!(venue_name: "Jamaica", venue_street_address: "99 Bottles Rd",
    venue_latitude: 93.023021, venue_longitude: 89.903232, shout: "Im drinking", 
    checkins_at: DateTime.now)
    Checkin.create!(venue_name: "Gymie", venue_street_address: "33 Twerking Rd",
    venue_latitude: 104.023021, venue_longitude: 90.903232, shout: "Getting swole", 
    checkins_at: DateTime.now)
    get :index, format: :json
    expect(response.body).to include "Getting swole"
    expect(response.body).to include "99 Bottles Rd"
  end

  it "should recieve post request for new checkin" do
    post :create, format: :json, 
    checkin: { venue_name: "Jamaica", 
    venue_street_address: "99 Bottles Rd",
    venue_latitude: 93.023021, 
    venue_longitude: 89.903232, 
    shout: "good times", 
    checkins_at: DateTime.now, 
    user_id: User.last.id }
    expect(Checkin.last.shout).to eq "good times"
    expect(response.body).to include "201"
    expect(response.body).to include "good times"
  end
end
