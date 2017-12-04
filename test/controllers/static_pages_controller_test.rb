require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'SharedBlog'
  end

  test 'should get about' do
    get about_path
    assert_response :success
    # assert_select 'title', "About | #{@base_title}"
    assert_select 'title', full_title('About')
  end

  test 'should get help' do
    get help_path
    assert_response :success
    # assert_select 'title', "Help | #{@base_title}"
    assert_select 'title', full_title('Help')
  end

end
