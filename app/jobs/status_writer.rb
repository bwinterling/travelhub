require 'json'
class StatusWriter
  @queue = :writer

  def self.perform(input)
    params = JSON.parse(input)
    client = self.client(params)
    self.store_statuses(client, params["user_id"],
			params["starts_on"], params["ends_on"])
  end

<<<<<<< HEAD
  def self.client(credentials = {})
    @client = Twitter::Client.new
    @client.consumer_key    = TWITTER_CONSUMER_KEY
    @client.consumer_secret = TWITTER_CONSUMER_SECRET
    @client.oauth_token     = credentials["oauth_token"]
    @client.oauth_token_secret = credentials["oauth_token_secret"]
    return @client
  end

  def self.store_statuses(client, user_id, starts_at, ends_at)
=======
  def self.store_statuses(client, user_id, starts_on, ends_on)
>>>>>>> 2bce73fc6197c623f2818ddf4577c5ec8a6b3cad
    timeline = client.user_timeline(client.user.id, count:200)
    statuses = timeline.select do |status|
      status.created_at > starts_on  && status.created_at < ends_on
    end
    conn = self.set_connection
    statuses.map do |status|
      conn.post do |req|
	req.url 'api/v1/statuses'
	req.headers['Content-Type'] = 'application/json'
	req.body = { status: { user_id: user_id, text: status.full_text,
			sent_at: status.created_at }}.to_json
      end
    end
  end

  def self.set_connection
    Faraday.new(:url => CURRENT_URI) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

end
