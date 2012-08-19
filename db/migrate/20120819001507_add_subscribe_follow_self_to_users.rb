class AddSubscribeFollowSelfToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribe_follow_self, :boolean, :default => true
    add_index :users, :subscribe_follow_self
  end
end
