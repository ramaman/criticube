class CreateVanities < ActiveRecord::Migration
  def change
    create_table :vanities do |t|
      t.string :name, :null => false
      t.integer :owner_id, :null => false
      t.string :owner_type, :null => false

      t.timestamps
    end
    add_index :vanities, :name, :unique => true
    add_index :vanities, :owner_type
    add_index :vanities, [:owner_type, :owner_id]
  end
end
