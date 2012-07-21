class CreateCubes < ActiveRecord::Migration
  def change
    create_table :cubes do |t|
      t.string :name
      t.string :tipe
      t.text :description
      t.string :language
      t.string :owner_type
      t.integer :owner_id
      t.timestamps
    end
    add_index :cubes, :name
    add_index :cubes, :tipe
    add_index :cubes, :language            
    add_index :cubes, [:owner_type, :owner_id]
    add_index :cubes, [:name, :owner_type, :owner_id]
  end
end
