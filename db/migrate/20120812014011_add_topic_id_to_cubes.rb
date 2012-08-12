class AddTopicIdToCubes < ActiveRecord::Migration
  def change
    add_column :cubes, :topic_id
    add_index :cubes, :topic_id
  end
end
