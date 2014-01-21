class User < ActiveRecord::Base

  has_many :trips
  has_many :feed_sources
  has_many :photos
  has_many :statuses
  has_many :checkins
  validates :name, :presence => true

  def possessive_name
    name.ends_with?("s") ? name + "'" : name + "'s"
  end

  def self.from_omniauth(auth)
    user = User.find_or_create_by(
      name:          auth["info"]["nickname"]
      )

    user.update_attributes(
      uid:      auth["uid"],
      provider: auth["provider"],
      avatar_url:    auth["info"]["image"],
      access_token:  auth["credentials"]["token"],
      access_secret: auth["credentials"]["secret"]
      )

    user
  end
end
