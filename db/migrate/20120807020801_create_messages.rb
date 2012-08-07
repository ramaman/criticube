class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id, :null => false
      t.integer :recipient_id, :null => false
      t.text :body
      t.boolean :read, :null => false, :default => false

      t.timestamps
    end
    add_index :messages, :read
    add_index :messages, :sender_id
    add_index :messages, :recipient_id
    add_index :messages, [:sender_id, :recipient_id]
    add_index :messages, [:read, :recipient_id]
    add_index :messages, :created_at
  end
end
