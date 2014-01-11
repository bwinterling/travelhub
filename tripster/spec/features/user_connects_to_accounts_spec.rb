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
    binding.pry
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
