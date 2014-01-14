require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      :provider => 'twitter',
      :uid => '123545',
      :info => {
        :nickname => 'rolen'},
      :credentials => {
	:token => "15334617-RNooHjcKSz92pLcoYLs7VYIlvikGRhihd30KYJB92"}
    })
    @user = User.from_omniauth(OmniAuth.config.mock_auth[:twitter])
  end

  def test_mock_user_is_saved
    assert_equal @user.provider, 'twitter'
    assert_equal @user.uid, '123545'
  end

  # ------ changed login to twitter... tests not needed --------

  # def test_new_user
  #   refute @user.save
  # end

  # def test_validates_presence_of_email
  #   @user.update(:email => "test@example.com")
  #   assert @user.save
  # end

  # def test_validates_uniqueness_of_email
  #   @user.update(:email => "test@example.com")
  #   assert @user.save
  #   assert_raise ActiveRecord::RecordInvalid do
  #     User.create!(:email => "test@example.com")
  #   end
  # end
end
