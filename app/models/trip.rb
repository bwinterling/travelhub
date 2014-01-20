class Trip < ActiveRecord::Base
  validates :name, presence: true
  validates :starts_at, presence: true
  validate :correct_dates
  belongs_to :user

  def correct_dates
    if ends_at && starts_at > ends_at
      errors.add(:starts_at, "ends_at must be after starts_at")
    end
  end

  
end
