#Instagram

if Rails.env.production?
  PHOTOS_CALLBACK_URL = "http://afternoon-chamber-5947.herokuapp.com/feeds/photos/callback"
  CHECKIN_REDIRECT_URI = "http://afternoon-chamber-5947.herokuapp.com/feeds/checkins/callback"
else
  PHOTOS_CALLBACK_URL = "http://localhost:3000/feeds/photos/callback"
  CHECKIN_REDIRECT_URI = "http://localhost:3000/feeds/checkins/callback"
end

PHOTO_PROVIDER = "Instagram"
CHECKIN_PROVIDER = "Foursquare"

Instagram.configure do |config|
  config.client_id = ENV["INSTAGRAM_CLIENT_ID"]
  config.client_secret = ENV["INSTAGRAM_CLIENT_SECRET"]
end

TWITTER_CONSUMER_KEY = ENV["TWITTER_CONSUMER_KEY"]
TWITTER_CONSUMER_SECRET = ENV["TWITTER_CONSUMER_SECRET"]

FOURSQUARE_CLIENT_ID = ENV["FOURSQUARE_CLIENT_ID"]
FOURSQUARE_CLIENT_SECRET = ENV["FOURSQUARE_CLIENT_SECRET"]
