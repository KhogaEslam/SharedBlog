require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

#Put some colors to the test results
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # to be able to author 'full_title' helper function
  include ApplicationHelper

  # Returns true if a test author is logged in.
  def is_logged_in?
    !session[:author_id].nil?
  end

  # Log in as a particular author.
  def log_in_as(author)
    session[:author_id] = author.id
  end
end

class ActionDispatch::IntegrationTest

  # Log in as a particular author.
  def log_in_as(author, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: author.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end
