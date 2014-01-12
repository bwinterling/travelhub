class MessagesAPI < ActiveRecord::Base
  attr_reader :client

  def initialize(current_user)
    @current_user = current_user
    @client = Twitter::Client.new
    @client.consumer_key    = TWITTER_CONSUMER_KEY
    @client.consumer_secret = TWITTER_CONSUMER_SECRET
    @client.oauth_token     = @current_user.access_token
    @client.oauth_token_secret = @current_user.access_secret
  end


  #using Twitter
  # #check initializers/feeds.rb for setup info
  # def self.connect_url
  #   Twitter.authorize_url(:redirect_uri => MESSAGES_CALLBACK_URL)
  # end
end
