class Photo < ActiveRecord::Base
  belongs_to :user

  validates :user_id,       :presence => true
  validates :photo_id,      :presence => true,
                            :uniqueness => true
  validates :thumbnail_url, :presence => true
  validates :standard_url,  :presence => true
  validates :photo_taken,   :presence => true

end
