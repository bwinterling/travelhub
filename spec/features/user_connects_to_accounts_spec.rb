require 'spec_helper'

describe 'User can connect to' do

  it 'instagram account', js: true do
    pending
    visit root_path
    click_on "Login with Twitter"
    click_on "Connect with Instagram"
    fill_in "Username", with: "MappingKat"
    fill_in "Password", with: "eeri44"

    click_on "Log in"
    expect(page).to have_content "Connection to Instagram Successful!"
  end

  it 'foursquare account'  do
     visit root_path
     user = User.from_omniauth(OmniAuth.config.mock_auth[:twitter])
     user.feed_sources.find_or_create_by(:provider => CHECKIN_PROVIDER, :token => "sha16")

     click_on "Login with Twitter"
     Feeds::CheckinsController.any_instance.stub(:params).and_return(:code =>"md5hash")
     Feeds::CheckinsController.any_instance.stub(:current_user).and_return(User.first)
     click_on "Login with Foursquare"
     expect(page).to have_content "Connection to Foursquare Successful!"
   end
end
