require 'test_helper'

class FollowsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'create should require logged-in author' do
    assert_no_difference 'Follow.count' do
      post follows_path
    end
    assert_redirected_to login_url
  end

  test 'destroy should require logged-in author' do
    assert_no_difference 'Follow.count' do
      delete follow_path(follows(:one))
    end
    assert_redirected_to login_url
  end

end
