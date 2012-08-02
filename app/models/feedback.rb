class Feedback < ActiveRecord::Base

  attr_accessible :tipe,
                  :content

  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'

  validates :tipe,
            :presence => true,
            :inclusion => { :in => %w(Idea Problem Question Comment Miscellaneous)} 
  validates :content,
            :presence => true,
            :length => { :maximum => 3550, :allow_nil => true, :allow_blank => true }             

end