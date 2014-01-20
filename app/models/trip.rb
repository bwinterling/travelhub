class Trip < ActiveRecord::Base

  validates :name, presence: true
  validates :starts_at, presence: true
  validate :correct_dates
  has_many :trip_users
  has_many :users, through: :trip_users

  def correct_dates
    if ends_at && starts_at > ends_at
      errors.add(:starts_at, "ends_at must be after starts_at")
    end
  end

  def update_feeds_for(trip_id)
    trip = Trip.find(trip_id)
    trip.users.each do |user|
      if user.provider == STATUS_PROVIDER
        StatusesAPI.feed_for(user.id, trip.starts_at, trip.ends_at)
      end
      if user.feed_sources.find_by(:provider => PHOTO_PROVIDER)
        PhotosAPI.feed_for(user.id, trip.starts_at, trip.ends_at)
      end
      if user.feed_sources.find_by(:provider => CHECKIN_PROVIDER)
        CheckinsAPI.feed_for(user.id, trip.starts_at, trip.ends_at)
      end
    end
  end

  def participant_ids
    user_ids = self.users.map { |user| user.id }
  end

  def photos
    Photo.where("user_id = ? AND photo_taken >= ? AND photo_taken <= ?", participant_ids, self.starts_at, self.ends_at)
  end

  def statuses
    Status.where("user_id = ? AND sent_at >= ? AND sent_at <= ?", participant_ids, self.starts_at, self.ends_at)
  end

  def checkins
    Checkin.where("user_id = ? AND checkins_at >= ? AND checkins_at <= ?", participant_ids, self.starts_at, self.ends_at)
  end

end
