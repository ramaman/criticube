class Reply < ActiveRecord::Base

  tipes = ['neutral', 'support', 'challenge']

  attr_accessible :content

  belongs_to  :creator, 
              :class_name => 'User',
              :foreign_key => 'creator_id'

  validates :tipe,
            :inclusion => { :in => tipes, :message => "is not supported"}

end
