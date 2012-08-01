class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :actor_id, :null => false
      t.string :action, :null => false

      t.string :primary_objekt_type, :null => false
      t.integer :primary_objekt_id, :null => false

      t.string :secondary_objekt_type
      t.integer :secondary_objekt_id

      t.string :tertiary_objekt_type
      t.integer :tertiary_objekt_id

      t.boolean :archived
      t.timestamps
    end
    add_index :activities, :actor_id
    add_index :activities, :action

    add_index :activities, [:primary_objekt_type, :primary_objekt_id], :name => 'primary_objekt'
    add_index :activities, [:secondary_objekt_type, :secondary_objekt_id], :name => 'secondary_objekt'
    add_index :activities, [:tertiary_objekt_type, :tertiary_objekt_id], :name => 'tertiary_objekt'

    add_index :activities, :archived            
    add_index :activities, :created_at, :sortable => true
    add_index :activities, :updated_at, :sortable => true    
  end
end
