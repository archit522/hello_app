require 'test_helper'

class ManagerTest < ActiveSupport::TestCase
  def setup
    @manager = Manager.new(name: "Example Manager", email: "manager@example.com", password: "foobar", password_confirmation: "foobar")
  end
  test "should be valid" do
    assert @manager.valid?
  end
  test "name should be present" do
    @manager.name = ""
    assert_not @manager.valid?
  end
  test "email should be present" do
    @manager.email = " "
    assert_not @manager.valid?
  end
  test "name should not be too long" do
    @manager.name = "a" * 51
    assert_not @manager.valid?
  end
  test "email should not be too long" do
    @manager.email = "a" * 244 + "@example.com"
    assert_not @manager.valid?
  end
  test "email validation should accept valid addresses" do
    valid_addresses = %w[manager@example.com Manager@foo.COM A_US-ER@foo.bar.org
    first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @manager.email = valid_address
      assert @manager.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[manager@example,com manager_at_foo.org manager.name@example.
    foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @manager.email = invalid_address
      assert_not @manager.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  test "email addresses should be unique" do
    duplicate_manager = @manager.dup
    duplicate_manager.email = @manager.email.upcase
    @manager.save
    assert_not duplicate_manager.valid?
  end
  test "password should have a minimum length" do
    @manager.password = @manager.password_confirmation = "a" * 5
    assert_not @manager.valid?
  end
end
