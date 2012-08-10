class AddInternalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cc_team, :boolean, :default => false
    add_index :users, :cc_team
  end
end
