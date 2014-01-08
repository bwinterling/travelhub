require 'spec_helper'

describe 'User can sign in' do
  User.create!(email: "rolen@example.com")

  it 'can login in' do
    visit new_session_path
    within ".login" do
      fill_in "Email", with: "rolen@example.com"
      click_on "Login"
    end
    expect(page).not_to have_content "Login"
    expect(page).to have_content "Logout"
  end

  it 'can sign out' do
    visit new_session_path
    within ".login" do
      fill_in "Email", with: "rolen@example.com"
      click_on "Login"
    end

    visit root_path
    click_on "Logout"
    expect(page).to have_content "Login"
    expect(page).not_to have_content "Logout"
  end

end

