require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase
  def setup
    @employee = employees(:michael)
    @other_employee = employees(:archer)
  end
  test "should get new" do
    get :new
    assert_response :success
  end
  test "should redirect edit when not logged in" do
    get :edit, id: @employee
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  test "should redirect update when not logged in" do
    patch :update, id: @employee, employee: { name: @employee.name, email: @employee.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  test "should redirect edit when logged in as wrong employee" do
    log_in_as(@other_employee)
    get :edit, id: @employee
    assert flash.empty?
    assert_redirected_to root_url
  end
  test "should redirect update when logged in as wrong employee" do
    log_in_as(@other_employee)
    patch :update, id: @employee, employee: { name: @employee.name, email: @employee.email }
    assert flash.empty?
    assert_redirected_to root_url
  end
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Employee.count' do
      delete :destroy, id: @employee
    end
    assert_redirected_to login_url
  end
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_employee)
    assert_no_difference 'Employee.count' do
      delete :destroy, id: @employee
    end
    assert_redirected_to root_url
  end
end
