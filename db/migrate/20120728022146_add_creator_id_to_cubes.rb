class AddCreatorIdToCubes < ActiveRecord::Migration
  def change
    add_column :cubes, :creator_id, :integer
    add_index :cubes, :creator_id
    add_index :cubes, [:creator_id, :tipe]
  end
end
