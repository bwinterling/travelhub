class PhotosAPI < ActiveRecord::Base
  #using Instagram
  #check initializers/feeds.rb for setup info
  def self.connect_url
    Instagram.authorize_url(:redirect_uri => PHOTOS_CALLBACK_URL)
  end

  def self.callback(code, current_user_id)
    response = Instagram.get_access_token(code, :redirect_uri => PHOTOS_CALLBACK_URL)
    User.find(current_user_id).feed_sources.where(:provider => "instagram", 
                                                  :token => response.access_token).first_or_create
  end
end
