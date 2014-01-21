require 'json'

class PhotoWriter
  @queue = :writer
  def self.perform(input)
    params = JSON.parse(input)
    client = self.client(params["access_token"])
    self.store_photos(client, params["user_id"])
  end

  def self.client(access_token)
    Instagram.client( access_token: access_token)
  end

  def self.set_connection
    Faraday.new(:url => CURRENT_URI) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def self.store_photos(client, user_id)
    conn = self.set_connection

    client.user_recent_media.map do |photo|
      caption = photo.caption.text if photo.caption
      conn.post do |req|
	req.url 'api/v1/photos'
	req.headers['Content-Type'] = 'application/json'
	req.body = { photo: {
        :user_id  => user_id,
        :photo_id => photo.id,
        :thumbnail_url  => photo.images.thumbnail.url,
        :standard_url  => photo.images.standard_resolution.url,
        :caption  => caption,
        :photo_taken => DateTime.strptime(photo.created_time, "%s") } }.to_json
      end
    end

  end
end
