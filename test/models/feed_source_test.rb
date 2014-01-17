require 'test_helper'

class FeedSourceTest < ActiveSupport::TestCase

  def setup
    @user = User.where(:email => "user@example.com", :name => "Neck Beard").first_or_create
    @feed_source = @user.feed_sources.new
  end

  def valid_params
    {
      :provider => "instagram",
      :token => "3kj53kj44hg6"
    }
  end

  def test_validates_presence_of_provider
    @feed_source.update(valid_params)
    assert @feed_source.save
    @feed_source.update(:provider => nil)
    refute @feed_source.save
  end

end
