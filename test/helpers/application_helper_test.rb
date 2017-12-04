require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    assert_equal full_title,         'SharedBlog'
    assert_equal full_title('Help'), 'Help | SharedBlog'
    assert_equal full_title('About'), 'About | SharedBlog'
  end
end