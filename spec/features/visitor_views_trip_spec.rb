require 'spec_helper'

describe 'visitor viewing' do
  it 'trip page' do
    user = User.from_omniauth OmniAuth.config.mock_auth[:twitter]
    trip = Trip.create!(name: "Tanzania",
                        user_id: user.id,
                        description: "kili climbing",
                        starts_at: DateTime.now,
                        ends_at: DateTime.now + 4392095 )
    page.visit trip_path(trip)
    page.should have_content(trip.name)
  end
end
