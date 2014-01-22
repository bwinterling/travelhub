class Photo < ActiveRecord::Base
  belongs_to :user

  validates :user_id,       :presence => true
  validates :photo_id,      :presence => true,
                            :uniqueness => true
  validates :thumbnail_url, :presence => true
  validates :standard_url,  :presence => true
  validates :photo_taken,   :presence => true

  def timeline_hash
    {
      startDate: photo_taken.strftime("%Y,%m,%d"),
      endDate: photo_taken.+(1.day).strftime("%Y,%m,%d"),
      headline:"Instagram Photo",
      text:"<p>#{caption}</p>",
      # tag:"This is Optional",
      asset: {
        media: standard_url,
        thumbnail: thumbnail_url,
        credit: user.name,
        caption: caption
      }
    }
  end

end
