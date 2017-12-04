require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @author = authors(:khoga)
    remember(@author)
  end

  test 'current_author returns right author when session is nil' do
    assert_equal @author, current_author
    assert is_logged_in?
  end

  test 'current_author returns nil when remember digest is wrong' do
    @author.update_attribute(:remember_digest, Author.digest(Author.new_token))
    assert_nil current_author
  end

end