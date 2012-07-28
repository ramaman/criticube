class AddAncestryToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :ancestry, :string
    add_index :replies, :ancestry
  end
end
