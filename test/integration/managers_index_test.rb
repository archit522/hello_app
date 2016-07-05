require 'test_helper'

class ManagersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = managers(:michael)
    @non_admin = managers(:archer)
  end
=begin
  test "index including pagination" do
    log_in_as_manager(@manager)
    get managers_path
    assert_template 'managers/index'
    assert_select 'div.pagination'
    Manager.paginate(page: 1).each do |manager|
      assert_select 'a[href=?]', manager_path(manager), text: manager.name
    end
  end
=end
  test "index as admin including pagination and delete links" do
    log_in_as_manager(@admin)
    get managers_path
    assert_template 'managers/index'
    assert_select 'div.pagination'
    first_page_of_managers = Manager.paginate(page: 1)
    first_page_of_managers.each do |manager|
      assert_select 'a[href=?]', manager_path(manager), text: manager.name
      unless manager == @admin
        assert_select 'a[href=?]', manager_path(manager), text: 'delete',
        method: :delete
      end
    end
    assert_difference 'Manager.count', -1 do
      delete manager_path(@non_admin)
    end
  end
  test "index as non-admin" do
    log_in_as_manager(@non_admin)
    get managers_path
    assert_select 'a', text: 'delete', count: 0
  end
end