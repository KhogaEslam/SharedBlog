require 'test_helper'

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @author = authors(:khoga)
    @other_author = authors(:mrmr)
  end

  test 'should get Authors' do
    get authors_path
    assert_response :success
  end

  test 'should get new' do
    get signup_path
    assert_response :success
  end

  test 'should redirect edit when not logged in' do
    get edit_author_path(@author)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch author_path(@author), params: { author: { name: @author.name,
                                                    email: @author.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect edit when logged in as wrong author' do
    log_in_as(@other_author)
    get edit_author_path(@author)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect update when logged in as wrong author' do
    log_in_as(@other_author)
    patch author_path(@author), params: { author: { name: @author.name,
                                                    email: @author.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test 'should not allow the admin attribute to be edited via the web' do
    log_in_as(@other_author)
    assert_not @other_author.admin?
    patch author_path(@other_author), params: { author: { password: 'Password',
                                                          password_confirmation: 'Password',
                                                          admin: true } }
    assert_not @other_author.admin?
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Author.count' do
      delete author_path(@author)
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when logged in as a non-admin' do
    log_in_as(@other_author)
    assert_no_difference 'Author.count' do
      delete author_path(@author)
    end
    assert_redirected_to root_url
  end

  test 'should redirect following when not logged in' do
    get following_author_path(@author)
    assert_redirected_to login_url
  end

  test 'should redirect followers when not logged in' do
    get followers_author_path(@author)
    assert_redirected_to login_url
  end

  test 'should redirect favorites when not logged in' do
    get favorites_author_path(@author)
    assert_redirected_to login_url
  end

end
