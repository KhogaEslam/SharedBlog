require 'test_helper'

class ArticlesInterfaceTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end


  def setup
    @author = authors(:khoga)
  end

  test 'article interface' do
    log_in_as(@author)
    get root_path
    # assert_select 'div.pagination'
    # assert_select 'input[type=file]'
    # Invalid submission
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: '', content: '' } }
    end
    # assert_select 'div#error_explanation'
    # Valid submission
    title = 'This article really ties the room together'
    content = 'This article really ties the room together pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla'
    default_picture = fixture_file_upload('test/fixtures/default_article.jpg',
                                          'image/jpg')
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: title,
                                               content: content,
                                               defsult_picture: default_picture } }
    end
    assert_redirected_to author_path(@author)
    follow_redirect!
    get articles_path
    assert_match content.truncate(50), response.body
    # Delete post
    # assert_select 'a', text: 'delete'
    first_article = @author.articles.paginate(page: 1).first
    assert first_article.default_picture
    assert_difference 'Article.count', -1 do
      delete article_path(first_article)
    end
    # Visit different user (no delete links)
    get author_path(authors(:mrmr))
    assert_select 'a', text: 'delete', count: 0
  end

  test 'article sidebar count' do
    log_in_as(@author)
    get root_path
    assert_match 'Read All Articles!', response.body
    # Author with zero Articles
    other_author = authors(:bo2loz)
    log_in_as(other_author)
    get author_path(other_author)
    assert_match 'My Articles (0)', response.body
    other_author.articles.create!(title: 'An article', content: 'This article really ties the room together pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla pla')
    get author_path(other_author)
    assert_match 'My Articles (1)', response.body
  end
end
