require 'test_helper'

class AccountActivationsControllerTest < ActionController::TestCase
  def edit
    employee = Employee.find_by(email: params[:email])
    if employee && !employee.activated? && employee.authenticated?(:activation, params[:id])
    employee.update_attribute(:activated, true)
    employee.update_attribute(:activated_at, Time.zone.now)
    log_in employee
    flash[:success] = "Account activated!"
    redirect_to employee
    else
    flash[:danger] = "Invalid activation link"
    redirect_to root_url
    end
  end
end
