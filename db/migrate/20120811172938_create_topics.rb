class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name, :null => false
      t.string :slug
      t.text :description
      t.string :avatar
      t.integer :creator_id

      t.timestamps
    end
    add_index :topics, :name
    add_index :topics, :slug, :unique => true
    add_index :topics, :avatar
  end
end
