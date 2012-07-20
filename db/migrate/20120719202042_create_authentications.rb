class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id, :null => false
      t.string :uid, :null => false
      t.string :provider, :null => false
      t.string :token
      t.boolean :timeline
      t.integer :token_expires_at

      t.timestamps
    end
    add_index :authentications, :user_id
    add_index :authentications, :provider
    add_index :authentications, [:user_id, :provider], :unique => true
    add_index :authentications, [:uid, :provider], :unique => true
    add_index :authentications, [:timeline, :provider]
  end
end