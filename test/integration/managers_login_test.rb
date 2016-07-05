require 'test_helper'

class ManagersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @manager = managers(:michael)
  end
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "", manager: '0' }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  test "login with valid information" do
    get login_path
    post login_path, session: { email: @manager.email, password: 'foobar', manager: '1' }
    assert_redirected_to @manager
    follow_redirect!
    assert_template 'managers/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", manager_path(@manager)
  end
  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @manager.email, password: 'foobar', manager: '1'  }
    assert is_logged_in_manager?
    assert_redirected_to @manager
    follow_redirect!
    assert_template 'managers/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", manager_path(@manager)
    delete logout_path
    assert_not is_logged_in_manager?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", manager_path(@manager), count: 0
  end
  test "login with remembering" do
    log_in_as_manager(@manager, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end
  test "login without remembering" do
    log_in_as_manager(@manager, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
