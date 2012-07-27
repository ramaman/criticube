class AddSlugAndTipeToPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :cube_id

    add_column :posts, :slug, :string
    add_column :posts, :tipe, :string
    add_column :posts, :parent_type, :string
    add_column :posts, :parent_id, :integer

    add_index :posts, :slug, :unique => true
    add_index :posts, :tipe
    add_index :posts, [:tipe, :creator_id]
    add_index :posts, [:tipe, :parent_id, :parent_type]
  end
end
