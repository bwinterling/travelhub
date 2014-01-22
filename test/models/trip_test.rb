require 'test_helper'

class TripTest < ActiveSupport::TestCase
  attr_reader :user, :trip

  def setup
    @user = User.create!(valid_user_params)
    @trip = user.trips.create!(name: "Jamica",
            description: "... Plains, Massachusetts",
            starts_on: Date.today.next_month(-1),
            ends_on: Date.today)
  end

  def test_it_has_a_creator
    assert_equal @trip.users.last, user
  end

  def test_it_has_name
    assert_raises ActiveRecord::RecordInvalid do
     user.trips.create!
    end

    trip1 = user.trips.create!(name: "Jamica", description: "Marley",
      starts_on: Date.today.next_month(-1), ends_on: Date.today)
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
        starts_on: Date.today, ends_on: Date.today.next_month(-1))
    end

    assert trip.starts_on < trip.ends_on
    refute trip.starts_on > trip.ends_on
  end

  def valid_user_params
    {
      :email => "user@example.com",
      :name => "Neck Beard"
    }
  end
end
