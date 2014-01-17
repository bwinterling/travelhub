require 'spec_helper'

describe "Tripsters"  do
  context "as a trip owner" do
    it "can invite a tripster from the show page, and sends tweet" do
      visit root_path
      click_on "Login with Twitter"
      #trip = Trip.create!(name: "Tanzania",
                          #user_id: User.last.id,
                          #description: "kili climbing",
                          #starts_at: DateTime.now,
                          #ends_at: DateTime.now + 4392095 )
      visit new_trip_path
      fill_in "Name", with: "Siam"
      fill_in "Description", with: "ETC ETC ETC"
      fill_in "Start Date", with: "01/01/14"
      fill_in "End Date", with: "01/03/14"
      click_on "Submit"

      page.visit trip_path(Trip.all.last)

      click_on "Add Tripster"
      fill_in "Twitter Handle", :with => "@pzula"
      #InviteController.any_instance.stub(:current_user).and_return(User.first)
      click_on "Invite"
      page.should have_content("Your invite to @pzula was sent via Twitter")
    end

    it "can see whether invited tripsters have registered"
    it "can remove a tripster from the trip"
  end
  context "as an invited tripster" do
    it "can authenticate with twitter"
    it "once authenticated, can see invited trip on dashboard"
    it "cannot edit trip details"
  end
end
