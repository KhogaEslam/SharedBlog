require 'test_helper'

class AuthorsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @author = authors(:khoga)
  end

  test 'unsuccessful edit' do
    log_in_as(@author)
    get edit_author_path(@author)
    assert_template 'authors/edit'
    patch author_path(@author), params: { author: { name:  '',
                                                    email: 'foo@invalid',
                                                    password: 'foo',
                                                    password_confirmation: 'bar' } }

    assert_template 'authors/edit'
  end

  test 'successful edit' do
    log_in_as(@author)
    get edit_author_path(@author)
    assert_template 'authors/edit'
    name  = 'Foo Bar'
    email = 'foo@bar.com'
    patch author_path(@author), params: { author: { name:  name,
                                                    email: email,
                                                    password: '',
                                                    password_confirmation: '' } }
    assert_not flash.empty?
    assert_redirected_to @author
    @author.reload
    assert_equal name,  @author.name
    assert_equal email, @author.email
  end

  test 'successful edit with friendly forwarding' do
    get edit_author_path(@author)
    log_in_as(@author)
    assert_redirected_to edit_author_url(@author)
    name  = 'Foo Bar'
    email = 'foo@bar.com'
    patch author_path(@author), params: { author: { name:  name,
                                                    email: email,
                                                    password: '',
                                                    password_confirmation: '' } }
    assert_not flash.empty?
    assert_redirected_to @author
    @author.reload
    assert_equal name,  @author.name
    assert_equal email, @author.email
  end
end
