class Checkin < ActiveRecord::Base

  def self.location_data
    @checkins = Checkin.all
    @checkins.map do |checkin|
      if @checkins.count > 0
        {
          type: 'Feature',
          properties: {
                  name: checkin.venue_name,
                  address: checkin.venue_street_address,
                  comment: checkin.shout,
                  checkin_at: checkin.checkins_at
          },
        geometry: {
              type: 'Point',
              coordinates: [ checkin.venue_longitude, checkin.venue_latitude]
          }
        }
      end
    end.compact
  end
end
