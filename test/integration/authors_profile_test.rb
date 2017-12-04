require 'test_helper'

class AuthorsProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  # test "the truth" do
  #   assert true
  # end

  def setup
    @author = authors(:khoga)
  end

  test 'profile display' do
    get author_path(@author)
    assert_template 'authors/show'
    assert_select 'title', full_title(@author.name)
    assert_select 'h1', text: @author.name
    assert_select 'h1>img.gravatar'
    assert_match @author.articles.count.to_s, response.body
    assert_select 'div.pagination'
    @author.articles.paginate(page: 1, per_page: 10).each do |article|
      assert_match article.content.truncate(50), response.body
    end
  end

end
