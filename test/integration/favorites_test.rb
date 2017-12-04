require 'test_helper'

class FavoritesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @author = authors(:khoga)
    @article = articles(:five)
    log_in_as(@author)
  end

  test 'favorite page' do
    get favorites_author_path(@author)
    assert_not @author.favorites.empty?
    assert_match @author.favorites.count.to_s, response.body
    @author.favorites.each do |article|
      assert_select 'a[href=?]', article_path(article)
    end
  end

  test 'should favorite an article the standard way' do
    assert_difference '@author.favorites.count', 1 do
      post favorites_path, params: { article_id: @article.id }
    end
  end

  test 'should favorite an article with Ajax' do
    assert_difference '@author.favorites.count', 1 do
      post favorites_path, xhr: true, params: { article_id: @article.id }
    end
  end

  test 'should unfavorite an article the standard way' do
    @author.favorite(@article)
    favorite = @author.favorite_articles.find_by(article_id: @article.id)
    assert_difference '@author.favorites.count', -1 do
      delete favorite_path(favorite)
    end
  end

  test 'should unfavorite an article with Ajax' do
    @author.favorite(@article)
    favorite = @author.favorite_articles.find_by(article_id: @article.id)
    assert_difference '@author.favorites.count', -1 do
      delete favorite_path(favorite), xhr: true
    end
  end

end
