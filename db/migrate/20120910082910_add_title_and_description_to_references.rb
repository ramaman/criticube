class AddTitleAndDescriptionToReferences < ActiveRecord::Migration
  def change
    add_column :references, :title, :string, :null => false, :default => ''
    add_column :references, :description, :text
  end
end
