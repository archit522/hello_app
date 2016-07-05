class ManagersController < ApplicationController
  before_action :logged_in_manager, only: [:edit, :update, :index, :destroy]
  before_action :correct_manager, only: [:edit, :update]
  before_action :admin_manager, only: :destroy
  def new
    @manager = Manager.new
  end
  def show
    @manager = Manager.find(params[:id])
  end
  def create
    @manager = Manager.new(manager_params) # Not the final implementation!
    if @manager.save
      log_in_manager @manager 
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @manager
    else
      render 'new'
    end
  end
  def edit
    @manager = Manager.find(params[:id])
  end
  def update
    @manager = Manager.find(params[:id])
    if @manager.update_attributes(manager_params)
      flash[:success] = "Profile updated"
      redirect_to @manager
    # Handle a successful update.
    else
      render 'edit'
    end
  end
  def index
    @managers = Manager.paginate(page: params[:page])
  end
  def destroy
    Manager.find(params[:id]).destroy
    flash[:success] = "Manager deleted"
    redirect_to managers_url
  end
  def my
    @employees = Employee.where(manager_id: current_manager.id).paginate(page: params[:page])
  end
  private
  def manager_params
    params.require(:manager).permit(:name, :email, :password,
    :password_confirmation)
  end
  def logged_in_manager
    unless logged_in_manager?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  def correct_manager
    @manager = Manager.find(params[:id])
    redirect_to(root_url) unless current_manager?(@manager)
  end
  def admin_manager
    redirect_to(root_url) unless current_manager.admin?
  end
end
