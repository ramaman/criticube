class AddNotificationsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notifications_count, :boolean
  end
end
