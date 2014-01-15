require 'spec_helper'

describe "Tripsters"  do
  context "as a trip owner" do
    before(:each) do
      user = User.from_omniauth OmniAuth.config.mock_auth[:twitter]
      trip = Trip.create!(name: "Tanzania",
                          user_id: user.id,
                          description: "kili climbing",
                          starts_at: DateTime.now,
                          ends_at: DateTime.now + 4392095 )
      page.visit trip_path(trip)
    end

    it "can invite a tripster from the show page, and sends tweet" do
      click_on "Add Tripster"
      fill_in "Name", :with => "Persa"
      fill_in "Twitter Handle", :with => "@pzula"
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
