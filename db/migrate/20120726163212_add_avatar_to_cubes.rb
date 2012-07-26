class AddAvatarToCubes < ActiveRecord::Migration
  def change
    add_column :cubes, :avatar, :string
  end
end
