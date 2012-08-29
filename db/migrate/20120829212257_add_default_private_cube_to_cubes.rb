class AddDefaultPrivateCubeToCubes < ActiveRecord::Migration
  def change
    change_column :cubes, :private_cube, :boolean, :null => false, :default => false
  end
end
