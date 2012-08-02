class FixFeaturedAndOfficialColumnsInCubes < ActiveRecord::Migration
  def change
    change_column :cubes, :official, :boolean, :default => false
    change_column :cubes, :featured, :boolean, :default => false
  end
end
