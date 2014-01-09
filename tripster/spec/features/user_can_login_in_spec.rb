require 'spec_helper'

describe 'User can sign in' do

  it 'can login in' do
    visit root_path
    click_on "Login with Twitter"
    expect(page).not_to have_content "Login"
    expect(page).to have_content "Logout"
  end

  it 'can sign out' do
    visit root_path
    click_on "Login with Twitter"
    click_on "Logout"
    expect(page).to have_content "Login"
    expect(page).not_to have_content "Logout"
  end
end

describe 'User directed to dashboard' do
  it 'sees most recent trip' do
    visit root_path
    click_on "Login with Twitter"
    Trip.create!(name: "The Highlands", 
            description: "To get some pot", 
            starts_at: DateTime.now, 
            ends_at: DateTime.now + 5732458, 
            user_id: User.last.id)
    visit dashboard_path
    expect(page).to have_content(User.last.trips.last.name)
  end
end
