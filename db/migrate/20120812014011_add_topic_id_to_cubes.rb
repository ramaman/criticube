class AddTopicIdToCubes < ActiveRecord::Migration
  def change
    add_column :cubes, :topic_id, :integer
    add_index :cubes, :topic_id
  end
end
