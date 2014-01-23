class Checkin < ActiveRecord::Base
  belongs_to :user

  def google_map_url
    "http://maps.googleapis.com/maps/api/staticmap?zoom=15&size=600x400&markers=#{venue_latitude},#{venue_longitude}&sensor=false"
  end

  def timeline_hash
    {
      startDate: checkins_at.strftime("%Y,%m,%d"),
      endDate: checkins_at.+(1.day).strftime("%Y,%m,%d"),
      headline:"Foursquare",
      text:"<p>Checked in at #{venue_name}</p>",
      asset: {
        media: google_map_url,
        credit: user.name,
        caption: shout
      }
    }
  end
end
