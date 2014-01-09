require 'test_helper'

class TripTest < ActiveSupport::TestCase
  attr_reader :user, :trip

  def setup
    @user = User.create!(email: "test@example.com")
    @trip = user.trips.create!(name: "Jamica",
			      description: "... Plains, Massachusetts",
			      starts_at: DateTime.now,
			      ends_at: DateTime.now + (2*7*24*60*60))
  end

  def test_it_has_a_creator
    assert_equal trip.user, user
  end

  def test_it_has_name
    assert_raises ActiveRecord::RecordInvalid do
     user.trips.create!
    end

    trip1 = user.trips.create!(name: "Jamica", description: "Marley",
		       starts_at: DateTime.now, ends_at: DateTime.now + 1)

    assert trip1
  end

  def test_it_has_a_start_date
    assert_raise ActiveRecord::RecordInvalid do
      user.trips.create!(name: "Jamica")
    end
  end

  def test_start_date_is_before_end_date
    assert_raise ActiveRecord::RecordInvalid do
      user.trips.create!(name: "Jamica", description: "Moo Moo",
			 starts_at: DateTime.now,
			 ends_at: DateTime.now - 1)
    end

    assert trip.starts_at < trip.ends_at
    refute trip.starts_at > trip.ends_at
  end
end
