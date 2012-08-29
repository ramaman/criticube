class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :referable_type
      t.integer :referable_id
      t.string :referred_type
      t.integer :referred_id
      t.string :tipe
      t.integer :creator_id

      t.timestamps
    end
    add_index :references, [:referable_type, :referable_id]
    add_index :references, [:referred_type, :referred_id]
    add_index :references, :tipe
  end
end
