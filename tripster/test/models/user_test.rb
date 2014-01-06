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

  def test_validates_uniqueness_of_email
    @user.update(:email => "test@example.com")
    assert @user.save
    assert_raise ActiveRecord::RecordInvalid do 
      User.create!(:email => "test@example.com")
    end
  end
end
