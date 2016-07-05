class AddYManagerToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :y_manager, :integer
  end
end
