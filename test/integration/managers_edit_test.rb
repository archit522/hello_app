require 'test_helper'

class ManagersEditTest < ActionDispatch::IntegrationTest
  def setup
    @manager = managers(:michael)
  end
  test "unsuccessful edit" do
    log_in_as_manager(@manager)
    get edit_manager_path(@manager)
    assert_template 'managers/edit'
    patch manager_path(@manager), manager: { name: "", email: "foo@invalid", password: "foo", password_confirmation: "bar" }
    assert_template 'managers/edit'
  end
  test "successful edit" do
    log_in_as_manager(@manager)
    get edit_manager_path(@manager)
    assert_template 'managers/edit'
    name = "Foo Bar"
    email = "foo@bar.com"
    patch manager_path(@manager), manager: { name: name, email: email, password: "", password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @manager
    @manager.reload
    assert_equal @manager.name, name
    assert_equal @manager.email, email
  end
  test "successful edit with friendly forwarding" do
    get edit_manager_path(@manager)
    log_in_as_manager(@manager)
    assert_redirected_to edit_manager_path(@manager)
    name = "Foo Bar"
    email = "foo@bar.com"
    patch manager_path(@manager), manager: { name: name, email: email, password: "foobar", password_confirmation: "foobar" }
    assert_not flash.empty?
    assert_redirected_to @manager
    @manager.reload
    assert_equal @manager.name, name
    assert_equal @manager.email, email
  end
end
