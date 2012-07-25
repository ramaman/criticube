class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :tipe
      t.string :owner_type
      t.integer :owner_id
      t.string :on_type
      t.integer :on_id

      t.timestamps
    end
    add_index :roles, [:owner_id, :owner_type]
    add_index :roles, [:on_id, :on_type]
    add_index :roles, [:tipe, :owner_id, :owner_type, :on_id, :on_type], :unique => true, :name => 'unique_participation_combo'

  end
end
