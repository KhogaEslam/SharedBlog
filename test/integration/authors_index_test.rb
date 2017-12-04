require 'test_helper'

class AuthorsIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @author = authors(:khoga)
    @admin = authors(:khoga)
    @non_admin = authors(:mrmr)
  end

  test 'index including pagination' do
    # log_in_as(@author)
    get authors_path
    assert_template 'authors/index'
    assert_select 'div.pagination'
    Author.paginate(page: 1, per_page: 10).each do |author|
      assert_select 'a[href=?]', author_path(author), text: author.name
    end
  end

  test 'index as admin including pagination and delete links' do
    log_in_as(@admin)
    get authors_path
    assert_template 'authors/index'
    assert_select 'div.pagination'
    first_page_of_authors = Author.paginate(page: 1, per_page: 10)
    first_page_of_authors.each do |author|
      assert_select 'a[href=?]', author_path(author), text: author.name
      unless author == @admin
        assert_select 'a[href=?]', author_path(author), text: 'delete'
      end
    end
    assert_difference 'Author.count', -1 do
      delete author_path(@non_admin)
    end
  end

  test 'index as non-admin' do
    log_in_as(@non_admin)
    get authors_path
    assert_select 'a', text: 'delete', count: 0
  end

end
