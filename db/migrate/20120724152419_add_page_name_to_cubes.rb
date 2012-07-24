class AddPageNameToCubes < ActiveRecord::Migration
  def change
    add_column :cubes, :page_name, :string
    add_index :cubes, :page_name, :unique => true
  end
end
