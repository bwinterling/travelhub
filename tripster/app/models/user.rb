class User < ActiveRecord::Base

  has_many :trips

  def self.from_omniauth(auth)
    where(auth.slice("provider","uid")).first || create_from_omniauth(auth)
  end

  has_many :feed_sources

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
    end
  end
end
