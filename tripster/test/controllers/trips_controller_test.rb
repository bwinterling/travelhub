require 'test_helper'

class TripsControllerTest < ActionController::TestCase

  def test_new_trip
    get :new
    assert_response 302
  end
end

