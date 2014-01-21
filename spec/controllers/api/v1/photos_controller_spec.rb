require 'spec_helper'

describe Api::V1::PhotosController do
  before(:all) do
    @user = User.from_omniauth(OmniAuth.config.mock_auth[:twitter])
  end

  it "index should respond successful" do
    get :index, format: :json
    expect(response.status).to eq 200
  end

  it "should return an index of photos" do
    Photo.create!(user_id: @user.id, photo_id: "photoid12345",
		 thumbnail_url: "instagram.com/fake",
		 standard_url: "instagram.com/standard",
		 caption: "hello world",
		 photo_taken: DateTime.now)
    Photo.create!(user_id: @user.id, photo_id: "photoid09876",
		 thumbnail_url: "instagram.com/noreal",
		 standard_url: "instagram.com/standard",
		 caption: "hello world",
		 photo_taken: DateTime.now)
    get :index, format: :json
    expect(response.body).to include "hello world"
    expect(response.body).to include "instagram.com/fake"
  end

  it "should receive post request for a new photo" do
    post :create, format: :json,
                  photo: { user_id: @user.id,
			  photo_id: "8765129",
		          thumbnail_url: "instagram.com/fake",
		          standard_url: "instagram.com/standard",
		          caption: "hello world",
		          photo_taken: DateTime.now }
    expect(response.body).to include "hello world"
  end

end
