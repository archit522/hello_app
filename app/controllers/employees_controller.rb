class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
  end
  def new
    @employee = Employee.new
  end
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @employee
    else
      render 'new'
    end
  end
  private
  def employee_params
    params.require(:employee).permit(:name, :email, :password, :password_confirmation)
  end
end
