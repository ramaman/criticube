class FixUsersNotificationsCount < ActiveRecord::Migration
  def change
    remove_column :users, :notifications_count
    add_column :users, :notifications_count, :integer
  end
end