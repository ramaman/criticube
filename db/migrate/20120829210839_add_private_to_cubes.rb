class AddPrivateToCubes < ActiveRecord::Migration
  def change
    add_column :cubes, :private_cube, :boolean
    add_index :cubes, :private_cube
  end
end
