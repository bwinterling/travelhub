class User < ActiveRecord::Base

  has_many :trips
  has_many :feed_sources
  has_many :photos

  validates :name, :presence => true

  def possessive_name
    name.ends_with?("s") ? name + "'" : name + "'s"
  end

  def self.from_omniauth(auth)
    where(auth.slice("provider","uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
    end
  end
end
