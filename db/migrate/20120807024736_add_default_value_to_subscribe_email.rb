class AddDefaultValueToSubscribeEmail < ActiveRecord::Migration
  def change
    add_column :users, :subscribe_messages, :boolean, :default => true
  end
end
