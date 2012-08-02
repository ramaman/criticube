class AddOfficialToCubes < ActiveRecord::Migration
  def change
    add_column :cubes, :official, :boolean
    add_index :cubes, :official
    add_column :cubes, :featured, :boolean
    add_index :cubes, :featured
  end
end
