# Preview all emails at http://localhost:3000/rails/mailers/employee_mailer
class EmployeeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/employee_mailer/account_activation
  def account_activation
employee = Employee.first
employee.activation_token = Employee.new_token
EmployeeMailer.account_activation(employee)
end
# Preview this email at
# http://localhost:3000/rails/mailers/employeee_mailer/password_reset
def password_reset
EmployeeMailer.password_reset
end

end
