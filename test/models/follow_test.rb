require 'test_helper'

class FollowTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @follow = Follow.new(follower_id: authors(:khoga).id,
                         followed_id: authors(:mrmr).id)
  end

  test 'should be valid' do
    assert @follow.valid?
  end

  test 'should require a follower_id' do
    @follow.follower_id = nil
    assert_not @follow.valid?
  end

  test 'should require a followed_id' do
    @follow.followed_id = nil
    assert_not @follow.valid?
  end

end
