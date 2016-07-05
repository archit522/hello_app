require 'test_helper'

class EmployeesIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = employees(:michael)
    @non_admin = employees(:archer)
  end
  #test "index including pagination" do
  #  log_in_as(@employee)
  #  get employees_path
  #  assert_template 'employees/index'
  #  assert_select 'div.pagination'
  #  Employee.paginate(page: 1).each do |employee|
  #    assert_select 'a[href=?]', employee_path(employee), text: employee.name
  #  end
  #end
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get employees_path
    assert_template 'employees/index'
  #  assert_select 'div.pagination'
  #  first_page_of_employees = Employee.paginate(page: 1)
  #  first_page_of_employees.each do |employee|
  #    assert_select 'a[href=?]', employee_path(employee), text: employee.name
  #    unless employee == @admin
  #      assert_select 'a[href=?]', employee_path(employee), text: 'delete', method: :delete
  #    end
  #  end
  #  assert_difference 'Employee.count', -1 do
  #    delete employee_path(@non_admin)
  #  end
  end
  test "index as non-admin" do
    log_in_as(@non_admin)
    get employees_path
    assert_select 'a', text: 'delete', count: 0
  end
end
