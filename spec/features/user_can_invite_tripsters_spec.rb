require 'spec_helper'

describe "Tripsters"  do
  context "as a trip owner" do
    before :each do
      visit root_path
      click_on "Login with Twitter"
      visit new_trip_path
      fill_in "Name", with: "Siam"
      fill_in "Description", with: "ETC ETC ETC"
      fill_in "Start Date", with: "01/01/14"
      fill_in "End Date", with: "01/03/14"
      click_on "Submit"

      page.visit trip_path(Trip.all.last)
    end


    it "can invite a tripster from the show page, and sends tweet" do
      click_on "Add Tripster"
      handle = "@jsl_demo" + Random.rand(1000).to_s
      fill_in "Twitter Handle", :with => handle
      click_on "Invite"
      page.should have_content("Your invite to #{handle} was sent via Twitter")
    end

    it "can see whether invited tripsters have registered" do
      click_on "Add Tripster"
      handle = "@jsl_demo" + Random.rand(1000).to_s
      fill_in "Twitter Handle", :with => handle
      click_on "Invite"
      page.should have_content("Your invite to #{handle} was sent via Twitter")

      page.visit dashboard_path
      page.should have_content("Siam has the following invited Tripsters: tripstertk " + handle[1..-1])
    end

    it "can remove a tripster from the trip" do
      click_on "Add Tripster"
      handle = "@jsl_demo" + Random.rand(1000).to_s
      fill_in "Twitter Handle", :with => handle
      click_on "Invite"
      page.should have_content("Your invite to #{handle} was sent via Twitter")
      within(".tripsters") do
        within("#tripster_#{User.last.id}") do
          click_on("-")
        end
      end
      page.should have_content("#{handle} was removed from your trip!")
    end
  end
  context "as an invited tripster" do
    it "can authenticate with twitter"
    it "once authenticated, can see invited trip on dashboard"
    it "cannot edit trip details"
  end
end
