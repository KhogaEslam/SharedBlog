require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @article = articles(:one)
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: 'Lorem ipsum',
                                               content: 'Lorem ipsum dolor sit amet,
                                                         consectetur adipiscing elit.
                                                         Donec sed neque ut leo pulvinar vestibulum vel vitae ante.
                                                         Nulla urna mauris, semper mollis ipsum.
                                                         Maecenas ut leo nisl.
                                                         Nam bibendum iaculis orci eu faucibus.
                                                         Orci varius natoque penatibus et magnis dis parturient montes,
                                                         nascetur ridiculus mus.'} }
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Article.count' do
      delete article_path(@article)
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy for wrong article' do
    log_in_as(authors(:maimona))
    article = articles(:five)
    assert_no_difference 'Article.count' do
      delete article_path(article)
    end
    assert_redirected_to root_url
  end

  test 'should not redirect destroy if author is admin' do
    log_in_as(authors(:khoga))
    article = articles(:five)
    assert_difference 'Article.count', -1 do
      delete article_path(article)
    end
    assert_redirected_to root_url
  end
end
