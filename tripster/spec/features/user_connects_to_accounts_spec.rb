require 'spec_helper'

describe 'User can connect to' do

  it 'instagram account', js: true do
    visit root_path
    click_on "Login with Twitter"
    click_on "Connect with Instagram"
    save_and_open_page
    expect(page).to have_content "Connection to Instagram Successful!" 
  end

  #  it 'twitter account' do
  #   visit root_path
  #   click_on "Login with Twitter"
  #   click_on "Connect with Twitter"
  #   expect(page).to have_content "Connection to Twitter Successful!" 
  # end

  #  it 'foursquare account' do
  #   visit root_path
  #   click_on "Login with Foursquare"
  #   click_on "Connect with Instagram"
  #   expect(page).to have_content "Connection to Foursquare Successful!" 
  # end
end
