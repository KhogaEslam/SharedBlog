require 'test_helper'

class AuthorsSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'Author.count' do
      post authors_path, params: { author: { name:  '',
                                             email: 'author@invalid',
                                             password:              'foo',
                                             password_confirmation: 'bar' } }
    end
    assert_template 'authors/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'Author.count', 1 do
      post authors_path, params: { author: { name: 'Example Author',
                                             email: 'ex@example.com',
                                             password: 'password',
                                             password_confirmation: 'password' } }
    end
    follow_redirect!
    assert_template 'authors/show'
    assert flash
    assert is_logged_in?
  end
end
