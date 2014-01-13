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

  def messages
    messages_api = MessagesAPI.new(user)
    client =  messages_api.client
    messages = client.user_timeline(client.user.id, count: 200)

    messages = messages.select { |message| message.created_at > starts_at }

    if ends_at
      messages.select { |message| message.created_at < ends_at }
    end
  end
end
