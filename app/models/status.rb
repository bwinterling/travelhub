class Status < ActiveRecord::Base
  belongs_to :user
  validates :text, :presence => true
  validates :sent_at, :presence => true, uniqueness: { scope: :user_id,
						       message: "a user can only send on status at a time" }

  def timeline_hash
    {
      startDate: sent_at.strftime("%Y,%m,%d"),
      endDate: sent_at.+(1.day).strftime("%Y,%m,%d"),
      headline:"Twitter",
      text:"<p>I like hash tags!</p>",
      asset: {
        media: standard_url,
        thumbnail: thumbnail_url,
        credit: user.name,
        caption: caption
      }
    }
  end

end
