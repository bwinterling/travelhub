require 'test_helper'

class PhotosAPITest < ActiveSupport::TestCase
  attr_reader :user, :trip

  def setup
    @user = User.create(valid_user_params)
    user.feed_sources.create(valid_feed_source_params)
    trip = user.trips.where(valid_trip_params).first_or_create
  end

  def test_connect_url_returns_a_url
    assert PhotosAPI.connect_url.starts_with?("http")
  end

  #callback test should be a controller test

  # def test_feed_for_returns_photos
  #   assert PhotosAPI.feed_for(user.id, trip.starts_on, trip.ends_on)
  # end

  def valid_user_params
    {
      :email => "user@example.com",
      :name => "Neck Beard"
    }
  end

  def valid_feed_source_params
    {
      :provider => "Instagram",
      :token => "7082188.5b6e183.bd639ad26cec42e0be916543d9c22e64"
    }
  end

  def valid_trip_params
    {
      :name => "Long Strange Trip",
      :starts_on => "2005-01-01",
      :ends_on => "2014-01-31"
    }
  end
end
