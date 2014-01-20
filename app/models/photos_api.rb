class PhotosAPI < ActiveRecord::Base
  #using Instagram
  #check initializers/feeds.rb for setup info
  def self.connect_url
    Instagram.authorize_url(:redirect_uri => PHOTOS_CALLBACK_URL)
  end

  def self.callback(code, current_user_id)
    response = Instagram.get_access_token(code, :redirect_uri => PHOTOS_CALLBACK_URL)
   feed = User.find(current_user_id).feed_sources.where(:provider => PHOTO_PROVIDER).first_or_create
   feed.update(:token => response.access_token)
  end

  def self.feed_for(user_id, start_date, end_date)
    user = User.find(user_id)
    photo_source = user.feed_sources.find_by(:provider => PHOTO_PROVIDER)
    if photo_source
      token = photo_source.token
      client = Instagram.client(:access_token => token)
      store_photos(client, user.id)
    #   user.photos.where(:photo_taken => start_date...end_date)
    # else
    #   return nil
    end
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
        :photo_taken => DateTime.strptime(photo.created_time, "%s")
        ).first_or_create
    end
  end
end
