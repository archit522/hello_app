class AddRememberDigestToManagers < ActiveRecord::Migration
  def change
    add_column :managers, :remember_digest, :string
  end
end
