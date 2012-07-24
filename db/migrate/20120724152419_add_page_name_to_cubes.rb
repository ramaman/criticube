class AddPageNameToCubes < ActiveRecord::Migration
  def change
    add_column :users, :page_name, :string
    add_index :users, :page_name, :unique => true
  end
end
