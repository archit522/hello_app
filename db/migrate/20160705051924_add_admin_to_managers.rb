class AddAdminToManagers < ActiveRecord::Migration
  def change
    add_column :managers, :admin, :boolean, default: false
  end
end
