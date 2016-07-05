require 'test_helper'

class EmployeeMailerTest < ActionMailer::TestCase  
  test "account_activation" do
    employee = employees(:michael)
    employee.activation_token = Employee.new_token
    mail = EmployeeMailer.account_activation(employee)
    assert_equal "Account activation", mail.subject
    assert_equal [employee.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match employee.name, mail.body.encoded
    assert_match employee.activation_token, mail.body.encoded
    assert_match CGI::escape(employee.email), mail.body.encoded
  end
=begin
  test "account_activation" do
    mail = EmployeeMailer.account_activation
    assert_equal "Account activation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end
  test "password_reset" do
    mail = EmployeeMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end
=end
end
