class AddBannedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :banned, :boolean
    add_index :users, :banned
  end
end
