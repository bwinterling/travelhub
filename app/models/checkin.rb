class Checkin < ActiveRecord::Base
  belongs_to :user

  def google_map_url
    "http://maps.google.com/?q=#{venue_latitude},#{venue_longitude}"
  end

  def timeline_hash
    {
      startDate: checkins_at.strftime("%Y,%m,%d"),
      endDate: checkins_at.+(1.day).strftime("%Y,%m,%d"),
      headline:"Foursquare",
      text:"<p>Checked in at #{venue_name}</p>",
      asset: {
        media: "https://foursquare.com/rolentle/checkin/52d6f46e498ee3a629fa2e04",
        credit: user.name,
        caption: shout
      }
    }
  end
end
