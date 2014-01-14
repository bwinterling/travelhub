class CheckinsAPI

  def self.connect_url
    base_url = "https://foursquare.com/oauth2/authenticate"
    client_id = "?client_id=" + FOURSQUARE_CLIENT_ID
    response_type = "&response_type=code"
    redirect_uri = "&redirect_uri=" + CHECKIN_REDIRECT_URI
    base_url +  client_id + response_type + redirect_uri
  end
end
