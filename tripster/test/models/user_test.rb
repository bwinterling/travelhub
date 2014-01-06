require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new
  end

  def test_new_user
    refute @user.save
  end

  def test_validates_presence_of_email
    @user.update(:email => "test@example.com")
    assert @user.save
  end

end
