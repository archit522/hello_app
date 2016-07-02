ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  def is_logged_in?
    !session[:employee_id].nil?
  end
  def log_in_as(employee, options = {})
    password = options[:password] || 'foobar'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_path, session: { email: employee.email,
      password: password,
      remember_me: remember_me }
    else
      session[:employee_id] = employee.id
    end
  end
  private
  # Returns true inside an integration test.
  def integration_test?
    defined?(post_via_redirect)
  end
  # Add more helper methods to be used by all tests here...
end
