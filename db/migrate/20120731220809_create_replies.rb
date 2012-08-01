class CreateReplies < ActiveRecord::Migration
  def change
    drop_table :replies
    create_table :replies do |t|
      t.string :tipe
      t.text :content
      t.integer :creator_id
      t.integer :parent_id
      t.string :parent_type

      t.timestamps
    end
    add_index :replies, :tipe
    add_index :replies, :content
    add_index :replies, :creator_id
    add_index :replies, [:creator_id, :tipe]
    add_index :replies, [:parent_id, :parent_type]
  end
end
