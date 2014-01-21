class FeedUpdater
  def self.update_all
    puts "starting update"
    User.all.each do |user|
   puts "starting user #{user.name}"
   puts "#{user.name} has #{user.trips.count} trips"
      user.trips.each do |trip|
      puts "starting user #{trip.name}"
	params = {user_id: user.id, oauth_token: user.access_token,
	   oauth_token_secret: user.access_secret, starts_at: trip.starts_at, ends_on: trip.ends_at }.to_json
	puts "the params are #{params}"
	puts "finishing trip"
      end
	puts "finishing user"
    end
    puts "done"
  end
end
