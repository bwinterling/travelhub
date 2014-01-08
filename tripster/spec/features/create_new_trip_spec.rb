require 'spec_helper'

describe "Creating a Trip" do
  context "when not logged in" do
    it "user is redirected to somewhere else" do
      visit new_trip_path
      expect(current_path).not_to eq new_trip_path
    end
  end

  context "when logged in" do
    it "can be created" do
      visit new_session_path
      User.create!(email: "kat@example.com")

      within ".login" do
	fill_in "Email", with: "kat@example.com"
	click_on "Login"
      end

      visit new_trip_path
      fill_in "Name", with: "Siam"
      fill_in "Description", with: "ETC ETC ETC"
      fill_in "Start Date", with: "01/01/14"
      fill_in "End Date", with: "01/01/14"
      click_on "Submit"
      expect(page).to have_content Trip.last.name
    end
  end
end
