require 'spec_helper'


describe 'visitor viewing' do
  it 'trip page' do
    trip = Trip.create!(name: "Tanzania", 
                        description: "kili climbing", 
                        starts_at: DateTime.now,
                        ends_at: DateTime.now + 4392095 )
    page.visit trip_path(trip)
    save_and_open_page
    page.should have_content(trip.name)
  end
end
