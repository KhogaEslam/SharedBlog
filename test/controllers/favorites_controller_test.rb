require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get favor" do
    get favorites_favor_url
    assert_response :success
  end

  test "should get unfavor" do
    get favorites_unfavor_url
    assert_response :success
  end

end
