class Invite
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :trip_id
  attr_accessor :handle

  def initialize(trip_id)
    @trip_id = trip_id
  end

  #send invite function should validate that all req'd fields are present
end
