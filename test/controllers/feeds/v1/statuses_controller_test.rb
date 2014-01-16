require 'test_helper'

class Feeds::V1::StatusesControllerTest < ActionController::TestCase
  def test_index_works
    get :index
    body = JSON.parse(@response.body)
    assert_kind_of Hash, body
    assert body.include?("text")
  end
end
