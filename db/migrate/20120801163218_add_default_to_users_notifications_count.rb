class AddDefaultToUsersNotificationsCount < ActiveRecord::Migration
  def change
    change_column :users, :notifications_count, :integer, :default => 0
  end
end