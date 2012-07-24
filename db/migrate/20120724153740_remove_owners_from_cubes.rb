class RemoveOwnersFromCubes < ActiveRecord::Migration
  def change
    remove_column :cubes, :owner_type
    remove_column :cubes, :owner_id    
  end
end
