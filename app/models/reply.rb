class Reply < ActiveRecord::Base

  has_ancestry

  tipes = ['neutral', 'support', 'challenge']

  attr_accessible :content

  belongs_to  :creator, 
              :class_name => 'User',
              :foreign_key => 'creator_id'

  belongs_to  :container,
              :polymorphic => true                        

  validates :tipe,
            :inclusion => { :in => tipes, :message => "is not supported"}


end
