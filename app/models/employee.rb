class Employee < ActiveRecord::Base
  belongs_to :model
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save { self.email = email.downcase }
  before_create :create_activation_digest
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true
  def Employee.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
BCrypt::Engine.cost
BCrypt::Password.create(string, cost: cost)
  end
  def Employee.new_token
    SecureRandom.urlsafe_base64
  end
  def remember
    self.remember_token = Employee.new_token
    update_attribute(:remember_digest, Employee.digest(remember_token))
  end
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  def forget
    update_attribute(:remember_digest, nil)
  end
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end
  def send_activation_email
    EmployeeMailer.account_activation(self).deliver_now
  end
  def create_reset_digest
    self.reset_token = Employee.new_token
    update_attribute(:reset_digest, Employee.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  def send_password_reset_email
    EmployeeMailer.password_reset(self).deliver_now
  end
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  private
  def create_activation_digest
    self.activation_token = Employee.new_token
    self.activation_digest = Employee.digest(activation_token)
  end
  def downcase_email
    self.email = email.downcase
  end
end
