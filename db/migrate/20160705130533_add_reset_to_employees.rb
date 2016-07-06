class AddResetToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :reset_digest, :string
    add_column :employees, :reset_sent_at, :datetime
  end
end
