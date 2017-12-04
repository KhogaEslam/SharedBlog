require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @author = authors(:khoga)

    # @article = Article.new(title: 'Title Sample',
    #                        content: 'Lorem ipsum dolor sit amet,
    #                                  consectetur adipiscing elit.
    #                                  Donec sed neque ut leo pulvinar vestibulum vel vitae ante.
    #                                  Nulla urna mauris, semper mollis ipsum.
    #                                  Maecenas ut leo nisl.
    #                                  Nam bibendum iaculis orci eu faucibus.
    #                                  Orci varius natoque penatibus et magnis dis parturient montes,
    #                                  nascetur ridiculus mus.',
    #                        author_id: @author.id)

    @article = @author.articles.build(title: 'Title Sample',
                                      content: 'Lorem ipsum dolor sit amet,
                                      consectetur adipiscing elit.
                                      Donec sed neque ut leo pulvinar vestibulum vel vitae ante.
                                      Nulla urna mauris, semper mollis ipsum.
                                      Maecenas ut leo nisl.
                                      Nam bibendum iaculis orci eu faucibus.
                                      Orci varius natoque penatibus et magnis dis parturient montes,
                                      nascetur ridiculus mus.')
  end

  test 'should be valid' do
    assert @article.valid?
  end

  test 'author id should be present' do
    @article.author_id = nil
    assert_not @article.valid?
  end

  test 'title should be present' do
    @article.title = '   '
    assert_not @article.valid?
  end

  test 'title should be at most 150 characters' do
    @article.title = 'a' * 151
    assert_not @article.valid?
  end

  test 'content should be present' do
    @article.content = '   '
    assert_not @article.valid?
  end

  test 'content should be at least 300 characters' do
    @article.content = 'a' * 151
    assert_not @article.valid?
  end

  test 'order should be most recent first' do
    assert_equal articles(:four), Article.first
  end
end
