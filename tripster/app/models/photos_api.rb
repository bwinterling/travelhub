class PhotosAPI < ActiveRecord::Base
  #using Instagram
  #check initializers/feeds.rb for setup info
  def self.connect_url
    Instagram.authorize_url(:redirect_uri => PHOTOS_CALLBACK_URL)
  end

  def self.callback(code, current_user_id)
    response = Instagram.get_access_token(code, :redirect_uri => PHOTOS_CALLBACK_URL)
    User.find(current_user_id).feed_sources.where(:provider => PHOTO_PROVIDER, :token => response.access_token).first_or_create
  end

  def self.feed_for(user_id, start_date, end_date)
    user = User.find(user_id)
    token = FeedSource.find_by(:user_id => user_id, 
          :provider => PHOTO_PROVIDER).token
    client = Instagram.client(:access_token => token)
    store_photos(client, user.id)
    #right now, this returns all photos.  Need to figure out how to
    #limit by date
    user.photos.all
  end

  def self.store_photos(client, user_id)
    client.user_recent_media.each do |photo|
      caption = photo.caption.text if photo.caption
      Photo.where(
        :user_id  => user_id,
        :photo_id => photo.id,
        :thumbnail_url  => photo.images.thumbnail.url,
        :standard_url  => photo.images.standard_resolution.url,
        :caption  => caption,
        :photo_taken => Time.at(photo.created_time.to_i)
        ).first_or_create
    end
  end

  #EXAMPLE - for how to process the feed in Sinatra
  # html = "<h1>#{user.username}'s recent photos</h1>"
  # for media_item in client.user_recent_media
  #   html << "<img src='#{media_item.images.thumbnail.url}'>"
  # end
  # html
end
