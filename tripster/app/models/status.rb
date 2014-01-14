class Status < ActiveRecord::Base
  belongs_to :user
  validates :text, :presence => true
  validates :sent_at, :presence => true
end
