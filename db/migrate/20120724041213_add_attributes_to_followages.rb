class AddAttributesToFollowages < ActiveRecord::Migration
  def change
    add_column :followages, :follower_id, :integer
    add_column :followages, :followed_id, :integer
    add_column :followages, :followed_type, :string
    add_index :followages, :follower_id
    add_index :followages, [:followed_id, :followed_type]
    add_index :followages, [:follower_id, :followed_id, :followed_type], :unique => true, :name => 'followage_combo'
  end
end
