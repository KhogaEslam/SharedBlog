require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @author = authors(:khoga)
    @other = authors(:mrmr)
    log_in_as(@author)
  end

  test 'following page' do
    get following_author_path(@author)
    assert_not @author.following.empty?
    assert_match @author.following.count.to_s, response.body
    @author.following.each do |author|
      assert_select 'a[href=?]', author_path(author)
    end
  end

  test 'followers page' do
    get followers_author_path(@author)
    assert_not @author.followers.empty?
    assert_match @author.followers.count.to_s, response.body
    @author.followers.each do |author|
      assert_select 'a[href=?]', author_path(author)
    end
  end

  test 'should follow an author the standard way' do
    assert_difference '@author.following.count', 1 do
      post follows_path, params: { followed_id: @other.id }
    end
  end

  test 'should follow an author with Ajax' do
    assert_difference '@author.following.count', 1 do
      post follows_path, xhr: true, params: { followed_id: @other.id }
    end
  end

  test 'should unfollow an author the standard way' do
    @author.follow(@other)
    follow = @author.active_follows.find_by(followed_id: @other.id)
    assert_difference '@author.following.count', -1 do
      delete follow_path(follow)
    end
  end

  test 'should unfollow an author with Ajax' do
    @author.follow(@other)
    follow = @author.active_follows.find_by(followed_id: @other.id)
    assert_difference '@author.following.count', -1 do
      delete follow_path(follow), xhr: true
    end
  end

  test 'feed on Home page' do
    get root_path
    @author.feed.paginate(page: 1).each do |article|
      assert_match CGI.escapeHTML(article.content), article.content
    end
  end

end
