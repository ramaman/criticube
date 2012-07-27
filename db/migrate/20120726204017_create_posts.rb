class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :headline, :null => false
      t.text :content
      t.integer :creator_id
      t.integer :cube_id

      t.timestamps
    end
    add_index :posts, :headline
    add_index :posts, :creator_id
  end
end
