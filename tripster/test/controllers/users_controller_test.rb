require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def test_new_user
    get :new
    assert_response :success
  end

  def test_create_user

end
