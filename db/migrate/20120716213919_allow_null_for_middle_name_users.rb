class AllowNullForMiddleNameUsers < ActiveRecord::Migration
  def change
    remove_column :users, :middle_names
    add_column :users, :middle_names, :string
    add_index :users, :middle_names
  end
end
