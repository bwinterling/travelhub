class StatusesAPI < ActiveRecord::Base

  def self.client(user)
    @client = Twitter::REST::Client.new
    @client.consumer_key    = TWITTER_CONSUMER_KEY
    @client.consumer_secret = TWITTER_CONSUMER_SECRET
    @client.oauth_token     = user.access_token
    @client.oauth_token_secret = user.access_secret
    return @client
  end

  def self.feed_for(user_id, starts_on, ends_on)
    user = User.find(user_id)
    client = self.client(user)
    self.store_statuses(client, user.id, starts_on, ends_on)
  end

  def self.store_statuses(client, user_id, starts_on, ends_on)
    user = User.find(user_id)
    #add error handling rate limit exceeded
    begin
      timeline = client.user_timeline(client.user.id, count: 200)
      statuses = timeline.select do |status|
        status.created_at > starts_on  && status.created_at < ends_on
      end
      statuses.each do |status|
        user.statuses.find_or_create_by( text: status.full_text,
          sent_at: status.created_at,
				       origin_id: status.id)
      end
    rescue
      nil
    end
  end

  def self.send_update(user, message)
    client = self.client(user)
    client.update(message)
  end

  def self.valid_handle?(handle)
    handle.start_with?("@")
  end

  def self.provider
    "Twitter"
  end


  #using Twitter
  # #check initializers/feeds.rb for setup info
  # def self.connect_url
  #   Twitter.authorize_url(:redirect_uri => MESSAGES_CALLBACK_URL)
  # end
end
