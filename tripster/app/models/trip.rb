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

  def messages(current_user)
    messages_api = MessagesAPI.new(current_user)
    client =  messages_api.client
    @messages ||= client.user_timeline(client.user.id, count: 200).select do |message|
      if ends_at
	message.created_at > starts_at && message.created_at < ends_at
      else
	message.created_at > starts_at
      end
    end
  end
end
