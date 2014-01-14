#Instagram

if Rails.env.production?
  PHOTOS_CALLBACK_URL = "http://afternoon-chamber-5947.herokuapp.com/feeds/photos/callback"
else
  PHOTOS_CALLBACK_URL = "http://localhost:3000/feeds/photos/callback"
end

PHOTO_PROVIDER = "Instagram"

Instagram.configure do |config|
  config.client_id = ENV["INSTAGRAM_CLIENT_ID"]
  config.client_secret = ENV["INSTAGRAM_CLIENT_SECRET"]
end

TWITTER_CONSUMER_KEY = ENV["TWITTER_CONSUMER_KEY"]
TWITTER_CONSUMER_SECRET = ENV["TWITTER_CONSUMER_SECRET"]
