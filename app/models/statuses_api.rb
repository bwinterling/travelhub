class StatusesAPI < ActiveRecord::Base

  def self.client(user)
    @client = Twitter::Client.new
    @client.consumer_key    = TWITTER_CONSUMER_KEY
    @client.consumer_secret = TWITTER_CONSUMER_SECRET
    @client.oauth_token     = user.access_token
    @client.oauth_token_secret = user.access_secret
    return @client
  end

  def self.feed_for(user_id, starts_at, ends_at)
    user = User.find(user_id)
    client = self.client(user)
    self.store_statuses(client, user.id, starts_at, ends_at)
    user.statuses.where(:sent_at => starts_at...ends_at)
  end

  def self.store_statuses(client, user_id, starts_at, ends_at)
    user = User.find(user_id)
    timeline = client.user_timeline(client.user.id, count: 1000)

    statuses = timeline.select do |status|
      status.created_at > starts_at  && status.created_at < ends_at
    end

    statuses.each do |status|
      user.statuses.find_or_create_by( text: status.full_text,
				      sent_at: status.created_at)
    end
  end



  #using Twitter
  # #check initializers/feeds.rb for setup info
  # def self.connect_url
  #   Twitter.authorize_url(:redirect_uri => MESSAGES_CALLBACK_URL)
  # end
end
