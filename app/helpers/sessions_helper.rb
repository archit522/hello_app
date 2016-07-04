module SessionsHelper
  def log_in(employee)
    session[:employee_id] = employee.id
  end
  def logged_in?
    !current_employee.nil?
  end
  def log_out
    forget(current_employee)
    session.delete(:employee_id)
    @current_employee = nil
  end
  def remember(employee)
    employee.remember
    cookies.permanent.signed[:employee_id] = employee.id
    cookies.permanent[:remember_token] = employee.remember_token
  end
  def current_employee
     if (employee_id = session[:employee_id])
      @current_employee ||= Employee.find_by(id: employee_id)
     elsif (employee_id = cookies.signed[:employee_id])
       employee = Employee.find_by(id: employee_id)
       if employee && employee.authenticated?(cookies[:remember_token])
          log_in employee
          @current_employee = employee
       end
    end 
  end
  def forget(employee)
    employee.forget
    cookies.delete(:employee_id)
    cookies.delete(:remember_token)
  end
  def current_employee?(employee)
    employee == current_employee
  end
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  # Stores the URL trying to be accessed.
  def store_location
  session[:forwarding_url] = request.url if request.get?
end
end
