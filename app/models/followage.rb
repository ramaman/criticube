class Followage < ActiveRecord::Base

  allowed_followeds = ['User', 'Cube', 'Post']

  attr_accessible :followed_id, :followed_type

  belongs_to :follower, :class_name => 'User', :foreign_key => 'follower_id'
  belongs_to :followed, :polymorphic => :true

  validate  :followed_type,
            :inclusion => { :in => allowed_followeds, :message => "not supported"}
              
end
