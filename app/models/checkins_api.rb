class CheckinsAPI

  def self.client(user)
    access_token = user.feed_sources.where(:provider => CHECKIN_PROVIDER).first.token
    Foursquare2::Client.new(oauth_token: access_token)
  end

  def self.connect_url
    base_url = "https://foursquare.com/oauth2/authenticate"
    client_id = "?client_id=" + FOURSQUARE_CLIENT_ID
    response_type = "&response_type=code"
    redirect_uri = "&redirect_uri=" + CHECKIN_REDIRECT_URI
    base_url +  client_id + response_type + redirect_uri
  end

  def self.access_token_url(input_code)
    base_url = "https://foursquare.com/oauth2/access_token"
    client_id= "?client_id=" + FOURSQUARE_CLIENT_ID
    client_secret = "&client_secret=" + FOURSQUARE_CLIENT_SECRET
    grant_type = "&grant_type=authorization_code"
    redirect_uri = "&redirect_uri=" + CHECKIN_REDIRECT_URI
    code = "&code=" + input_code
    base_url + client_id + client_secret + grant_type + redirect_uri + code
  end

  def self.callback(input_code, user_id)
    access_token_url = self.access_token_url(input_code)
    response = Faraday.get access_token_url
    access_token = JSON.parse(response.body)["access_token"]
    user = User.find(user_id)
    feed = user.feed_sources.where(:provider => CHECKIN_PROVIDER).first_or_create
    feed.update(:token => access_token)
    @client = self.client(user)
  end

  def self.feed_for(user_id, starts_at, ends_at)
    user = User.find(user_id)
    client = self.client(user)
    self.store_checkins(client, user_id, starts_at, ends_at)
    user.checkins.where(:checkins_at => starts_at..ends_at)
  end

  def self.store_checkins(client,user_id, starts_at, ends_at)
    user = User.find(user_id)
    checkin_history = client.user_checkins.items

    checkins = checkin_history.select do |checkin|
      checkin_time = DateTime.strptime(checkin.createdAt.to_s, "%s")
      checkin_time > starts_at && checkin_time < ends_at
    end

    checkins.each do |checkin|
      location = checkin.venue.location
      checkins_at = DateTime.strptime(checkin.createdAt.to_s, "%s")
      user.checkins.where(
    	:user_id => user_id,
    	:venue_name => checkin.venue.name,
    	:venue_street_address => location.address,
    	:shout => checkin.shout,
    	:checkins_at => checkins_at).first_or_create.update_attributes(
    	:venue_latitude => location.lat,
    	:venue_longitude =>location.lng)
    end
  end
end
