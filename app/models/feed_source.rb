class FeedSource < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :presence => true
  validates :provider, :presence => true

end
