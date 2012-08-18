class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :owner_type
      t.integer :owner_id
      t.integer :creator_id
      t.string :image
      t.text :description
      t.timestamps
    end
    add_index :pictures, [:owner_type, :owner_id]
    add_index :pictures, :creator_id
  end
end
