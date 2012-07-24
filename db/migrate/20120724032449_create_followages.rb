class CreateFollowages < ActiveRecord::Migration
  def change
    create_table :followages do |t|

      t.timestamps
    end
  end
end
