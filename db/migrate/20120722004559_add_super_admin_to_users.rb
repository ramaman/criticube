class AddSuperAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :super_admin, :boolean
    add_index :users, :super_admin
  end
end
