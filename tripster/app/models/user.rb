class User < ActiveRecord::Base

  has_many :trips
  has_many :feed_sources
  has_many :photos

  def self.from_omniauth(auth)
    where(auth.slice("provider","uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.avatar_url = auth["info"]["image"]
      user.access_token = auth.extra.access_token.token
      user.access_secret = auth.extra.access_token.secret
    end
  end
end
