class EmployeesController < ApplicationController
  before_action :logged_in_employee, only: [:index, :edit, :update, :destroy]
  before_action :correct_employee, only: [:edit, :update]
  before_action :admin_employee, only: [:destroy, :index] 
  def index
    @employees = Employee.paginate(page: params[:page])
  end
  def show
    @employee = Employee.find(params[:id])
  end
  def new
    @employee = Employee.new
  end
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      @employee.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
  def edit
    @employee = Employee.find(params[:id])
  end
  def update
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(employee_params)
      flash[:success] = "Profile updated"
      redirect_to @employee
    else
      render 'edit'
    end
  end
  def destroy
  Employee.find(params[:id]).destroy
  flash[:success] = "Employee deleted"
  redirect_to employees_url
end
  private
  def employee_params
    params.require(:employee).permit(:name, :email, :password, :password_confirmation)
  end
  def logged_in_employee
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  def correct_employee
    @employee = Employee.find(params[:id])
    redirect_to(root_url) unless current_employee?(@employee)
  end
  def admin_employee
    redirect_to(root_url) unless current_employee.admin?
  end
end
