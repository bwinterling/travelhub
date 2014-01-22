class User < ActiveRecord::Base

  has_many :trip_users
  has_many :trips, through: :trip_users
  has_many :feed_sources
  has_many :photos
  has_many :statuses
  has_many :checkins
  validates :name, :presence => true, :uniqueness => true

  def possessive_name
    name.ends_with?("s") ? name + "'" : name + "'s"
  end

  def self.from_omniauth(auth)
    user = User.find_or_create_by(
      name:          auth["info"]["nickname"].downcase
    )
    user.update_attributes(
      uid:      auth["uid"],
      provider: auth["provider"],
      avatar_url:    auth["info"]["image"],
      access_token:  auth["credentials"]["token"],
      access_secret: auth["credentials"]["secret"],
      slug:  "/users/#{user.id}/edit"
    )
    user
  end

  def all_accounts_connected?
    feed_sources.map(&:provider).sort == User.providers
  end

  def self.providers
    ["Instagram", "Foursquare"].sort
  end


end
