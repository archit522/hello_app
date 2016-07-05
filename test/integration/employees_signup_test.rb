require 'test_helper'

class EmployeesSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Employee.count' do
      post employees_path, employee: { name:  "",email: "employee@invalid", password: "foo", password_confirmation: "bar" }
    end
    assert_template 'employees/new'
  end
  test "valid signup information" do
    get signup_path
    assert_difference 'Employee.count', 1 do
      post_via_redirect employees_path, employee: { name:  "Example Employee", email: "employee@example.com", password: "foobar", password_confirmation: "foobar" }
    end
    #assert is_logged_in?
    #assert_template 'employees/show'
  end
  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'Employee.count', 1 do
      post employees_path, employee: { name: "Example Employee", email: "employee@example.com", password: "password", password_confirmation: "password" }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    employee = assigns(:employee)
    assert_not employee.activated?
    # Try to log in before activation.
    log_in_as(employee)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(employee.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(employee.activation_token, email: employee.email)
    assert employee.reload.activated?
    follow_redirect!
    assert_template 'employees/show'
    assert is_logged_in?
  end
end
