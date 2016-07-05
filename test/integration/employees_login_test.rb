require 'test_helper'

class EmployeesLoginTest < ActionDispatch::IntegrationTest
  def setup
    @employee = employees(:michael)
  end
  test "login with valid information" do
    get login_path
    post login_path, session: { email: @employee.email, password: 'foobar', manager: false }
    assert_redirected_to @employee
    follow_redirect!
    assert_template 'employees/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", employee_path(@employee)
end
  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @employee.email, password: 'foobar', manager: false }
    assert is_logged_in?
    assert_redirected_to @employee
    follow_redirect!
    assert_template 'employees/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", employee_path(@employee)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count:0
    assert_select "a[href=?]", employee_path(@employee), count:0
  end
  test "login with remembering" do
    log_in_as(@employee, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@employee, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end