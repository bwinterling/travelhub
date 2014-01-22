class Status < ActiveRecord::Base
  belongs_to :user
  validates :text, :presence => true
  validates :sent_at, :presence => true, uniqueness: { scope: :user_id,
						       message: "a user can only send on status at a time" }
end
