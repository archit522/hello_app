require 'test_helper'
class SessionsHelperTest < ActionView::TestCase
  def setup
    #@employee = employees(:michael)
    #remember(@employee)
    @manager = managers(:michael)
    remember_manager(@manager)
  end
=begin
  test "current_employee returns right employee when session is nil" do
    assert_equal @employee, current_employee
    assert is_logged_in?
  end
  test "current_employee returns nil when remember digest is wrong" do
    @employee.update_attribute(:remember_digest, Employee.digest(Employee.new_token))
    assert_nil current_employee
  end
=end
  test "current_manager returns right manager when session is nil" do
    assert_equal @manager, current_manager
    #assert is_logged_in_manager?
  end
  test "current_manager returns nil when remember digest is wrong" do
    @manager.update_attribute(:remember_digest, Manager.digest(Manager.new_token))
    assert_nil current_manager
  end
end