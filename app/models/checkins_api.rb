class CheckinsAPI

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

  def self.connect(input_code)
    access_token_url = self.access_token_url(input_code)
    response = Faraday.get access_token_url
    access_token = JSON.parse(response.body)["access_token"]
    @client = Foursquare2::Client.new(oauth_token: access_token)
  end

end
