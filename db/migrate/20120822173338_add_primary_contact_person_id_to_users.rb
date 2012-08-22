class AddPrimaryContactPersonIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lead_id, :integer
    add_index :users, :lead_id
  end
end
