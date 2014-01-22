class Trip < ActiveRecord::Base

  validates :name, presence: true
  validates :starts_on, presence: true
  validate :correct_dates
  has_many :trip_users
  has_many :users, through: :trip_users

  def correct_dates
    if ends_on && starts_on > ends_on
      errors.add(:starts_on, "ends_on must be after starts_on")
    end
  end

  def create_trip(input)
    self.name = input[:name]
    self.description = input[:description]
    self.starts_on = check_date(input[:starts_on])
    self.ends_on = check_date(input[:ends_on])
    return self
  end

  def check_date(date)
    begin
      return Date.parse(date)
    rescue
      return nil
    end
  end

  def update_feeds
    self.active_users.each do |user|
      if user.provider == STATUS_PROVIDER
        StatusesAPI.feed_for(user.id, self.starts_on, self.ends_on)
      end
      if user.feed_sources.find_by(:provider => PHOTO_PROVIDER)
        PhotosAPI.feed_for(user.id, self.starts_on, self.ends_on)
      end
      if user.feed_sources.find_by(:provider => CHECKIN_PROVIDER)
        CheckinsAPI.feed_for(user.id, self.starts_on, self.ends_on)
      end
    end
  end

  def participant_ids
    self.active_users.map { |user| user.id }
  end

  def active_users
    trip_users.where(:active => true).map {|trip_user| User.find(trip_user.user_id) }
  end

  def photos
    Photo.where(user_id: participant_ids, photo_taken: self.starts_on...self.ends_on)
  end

  def statuses
    Status.where(user_id: participant_ids, sent_at: self.starts_on...self.ends_on)
  end

  def checkins
    Checkin.where(user_id: participant_ids, checkins_at: self.starts_on...self.ends_on)
  end

  def geojson
    #refactor this, it feels heavy
    geojson_array = Array.new
    checkins.each do |checkin|
      geojson_array << {
                    type: 'Feature',
                    geometry: {
                      type: 'Point',
                      coordinates: [checkin.venue_longitude, checkin.venue_latitude]
                    },
                    properties: {
                      name: checkin.venue_name,
                      address: checkin.venue_street_address,
                      # comment: checkin.shout,
                      :'marker-color' => '#00607d',
                      :'marker-symbol' => 'circle',
                      :'marker-size' => 'medium'
                    }
                  }
    end
    geojson_array
  end
end
