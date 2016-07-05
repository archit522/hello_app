class SessionsController < ApplicationController
  def new
  end
  def create
    if params[:session][:manager]=='1'
      manager = Manager.find_by(email: params[:session][:email].downcase)
      if manager && manager.authenticate(params[:session][:password])
        log_in_manager manager
        params[:session][:remember_me] == '1' ? remember_manager(manager) : forget_manager(manager)
        redirect_back_or manager
        # Log the manager in and redirect to the manager's show page.
      else
        flash.now[:danger] = "Invalid email/password combination"
        # Create an error message.
        render 'new'
      end
    else
      employee = Employee.find_by(email: params[:session][:email].downcase)
      if employee && employee.authenticate(params[:session][:password])
        log_in employee
        params[:session][:remember_me] == '1' ? remember(employee) : forget(employee)
        redirect_back_or employee
         # Log the employee in and redirect to the employee's show page.
      else
        flash.now[:danger] = "Invalid email/password combination"
        # Create an error message.
        render 'new'
      end
    end
  end
  def destroy
    if !current_employee.nil?
      log_out if logged_in?
      redirect_to root_url
    else
      log_out_manager if logged_in_manager?
      redirect_to root_url
    end
  end
end
