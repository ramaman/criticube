class Reference < ActiveRecord::Base

  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
  belongs_to :referable, :polymorphic => true
  belongs_to :referred, :polymorphic => true
    
  attr_reader :url_placeholder  

end
