class FeedUpdater
  def self.update_all
    User.all.each do |user|
      self.get_photos(user)

      user.trips.each do |trip|
	status_params = { user_id: user.id, oauth_token: user.access_token,
	                  oauth_token_secret: user.access_secret,
			  starts_on: trip.starts_on, ends_on: trip.ends_on}.to_json
	Resque.enqueue(StatusWriter, status_params)
      end
    end
  end


  def self.get_photos(user)
      photo_provider = user.feed_sources.where(provider: PHOTO_PROVIDER)

     unless  photo_provider.empty?
       token = photo_provider.first.token
       params = { access_token: token,  user_id: user.id}.to_json
       Resque.enqueue(PhotoWriter, params)
     end
  end
end
