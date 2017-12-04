require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @favorite = Favorite.new(author_id: authors(:khoga).id,
                             article_id: articles(:five).id)
  end

  test 'should be valid' do
    assert @favorite.valid?
  end

  test 'should require a author_id' do
    @favorite.author_id = nil
    assert_not @favorite.valid?
  end

  test 'should require a article_id' do
    @favorite.article_id = nil
    assert_not @favorite.valid?
  end
end
