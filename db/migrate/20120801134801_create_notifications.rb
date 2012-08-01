class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :activity_id
      t.boolean :read, :default => false      

      t.timestamps
    end
    add_index :notifications, :user_id
    add_index :notifications, [:user_id, :read]
    add_index :notifications, :activity_id
  end
end
