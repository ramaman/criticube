class Reference < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
  belongs_to :referable, :polymorphic => true
  belongs_to :referred, :polymorphic => true
    
end
