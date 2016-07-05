require 'test_helper'

class ManagersSignupmanagerTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Manager.count' do
      post managers_path, manager: { name: "", email: "manager@invalid", password: "foo", password_confirmation: "bar" }
    end
    assert_template 'managers/new'
  end
  test "valid signup information" do
    get signup_path
    assert_difference 'Manager.count', 1 do
      post_via_redirect managers_path, manager: { name: "Example Manager", email: "manager@example.com", password: "foobar", password_confirmation: "foobar" }
    end
    assert_template 'managers/show'
    assert is_logged_in_manager?
  end
end
