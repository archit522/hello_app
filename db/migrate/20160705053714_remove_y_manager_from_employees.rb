class RemoveYManagerFromEmployees < ActiveRecord::Migration
  def change
    remove_column :employees, :y_manager, :integer
  end
end
