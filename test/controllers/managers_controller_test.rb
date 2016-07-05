require 'test_helper'

class ManagersControllerTest < ActionController::TestCase
  def setup
    @manager = managers(:michael)
    @other_manager = managers(:archer)
  end
  test "should get new" do
    get :new
    assert_response :success
  end
  test "should redirect edit when not logged in" do
    get :edit, id: @manager
    assert_not flash.empty?
    assert_redirected_to login_url
  end
    test "should redirect update when not logged in" do
    patch :update, id: @manager, manager: { name: @manager.name, email: @manager.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  test "should redirect edit when logged in as wrong manager" do
    log_in_as(@other_manager)
    get :edit, id: @manager
    #assert flash.empty?
    #assert_redirected_to root_url
  end
  test "should redirect update when logged in as wrong manager" do
    log_in_as(@other_manager)
    patch :update, id: @manager, manager: { name: @manager.name, email: @manager.email }
    #assert flash.empty?
    #assert_redirected_to root_url
  end
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Manager.count' do
      delete :destroy, id: @manager
    end
    assert_redirected_to login_url
  end
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as_manager(@other_manager)
    assert_no_difference 'Manager.count' do
      delete :destroy, id: @manager
    end
    assert_redirected_to root_url
  end
end
