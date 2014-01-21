require 'spec_helper'

describe 'visitor viewing' do
  it 'trip page' do
    user = User.from_omniauth OmniAuth.config.mock_auth[:twitter]
    trip = Trip.create!(name: "Tanzania",
                        user_id: user.id,
                        description: "kili climbing",
                        starts_on: Date.today,
                        ends_on: Date.today.next_month(1) )
    page.visit trip_path(trip)
    page.should have_content(trip.name)
  end
end
