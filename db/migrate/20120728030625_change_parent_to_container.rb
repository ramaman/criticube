class ChangeParentToContainer < ActiveRecord::Migration
  def change
    remove_column :replies, :parent_id
    remove_column :replies, :parent_type
    add_column :replies, :container_id, :integer
    add_column :replies, :container_type, :string
    add_index :replies, [:container_id, :container_type]    
  end
end
