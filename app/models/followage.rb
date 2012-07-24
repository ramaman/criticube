class Followage < ActiveRecord::Base
  attr_accessible :followed_id, :followed_type

  belongs_to :follower, :class_name => 'User', :foreign_key => 'follower_id'
  belongs_to :followed, :polymorphic => :true
end
