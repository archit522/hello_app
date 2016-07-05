class AddActivationToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :activation_digest, :string
    add_column :employees, :activated, :boolean, default: false
    add_column :employees, :activated_at, :datetime
  end
end
