class Checkin < ActiveRecord::Base
  belongs_to :user

  def google_map_url
    "http://maps.google.com/?q=#{venue_latitude},#{venue_longitude}"
    "https://www.google.com/url?q=http://maps.google.com/maps%3Fq%3Dchicago%26hl%3Den%26sll%3D41.874961,-87.619054%26sspn%3D0.159263,0.351906%26t%3Dt%26hnear%3DChicago,%2BCook,%2BIllinois%26z%3D11&usd=2&usg=ALhdy28o-smFGlAQ-_jlleH2EmcQ1ZqfIg"
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
