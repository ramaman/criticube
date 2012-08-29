class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title, :null => false
      t.text :url, :null => false
      t.string :website
      t.string :language_code
      t.string :special_case

      t.text :description
      t.text :keywords
      t.boolean :internal

      t.text :preview_origin
      t.string :preview
      t.string :slug
      t.integer :creator_id
      t.boolean :active, :default => true
      t.boolean :delta, :default => true, :null => false
      t.timestamps
    end
    add_index :links, :title
    add_index :links, :url, :unique => true
    add_index :links, :website
    add_index :links, :language_code
    add_index :links, :special_case
    add_index :links, :creator_id

    add_index :links, :slug, :unique => true
  end
end
