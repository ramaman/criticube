class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :creator_id
      t.string :tipe
      t.text :content
      t.boolean :responded, :null => false, :default => false

      t.timestamps
    end
    add_index :feedbacks, :creator_id
    add_index :feedbacks, :tipe
    add_index :feedbacks, :responded 
    add_index :feedbacks, [:tipe, :responded]
    add_index :feedbacks, :created_at, :sortable => true
    add_index :feedbacks, :updated_at, :sortable => true           
  end
end
