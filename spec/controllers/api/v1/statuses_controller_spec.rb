require 'spec_helper'

describe Api::V1::StatusesController do
  before(:all) do
    User.from_omniauth(OmniAuth.config.mock_auth[:twitter])
  end
  it "index should respond successful" do
    get :index, format: :json
    expect(response.status).to eq 200
  end

  it "index should respond with all statuses" do
    Status.create!(text: "Rick Roll", user_id: User.last.id , sent_at: DateTime.now)
    Status.create!(text: "Wu Tang Clan", user_id: User.last.id , sent_at: DateTime.now)
    get :index, format: :json
    expect(response.body).to include "Rick Roll"
    expect(response.body).to include "Wu Tang Clan"
  end

  it "should receive post request for a new status" do
    post :create, :format => :json,
		     :status => { :text =>  "Posting Costner",
		     sent_at: DateTime.now,
		     user_id: User.last.id }
    expect(Status.last.text).to eq "Posting Costner"
    expect(response.body).to include "201"
    expect(response.body).to include "Posting Costner"
  end

end
