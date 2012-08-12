class Topic < ActiveRecord::Base

  extend FriendlyId

  friendly_id :name, :use => :slugged

  attr_accessible :name, :description, :avatar

  belongs_to  :creator,
              :class_name => 'User',
              :foreign_key => 'creator_id'  

  has_many  :cubes

  validates :name,
            :presence => true,
            :uniqueness => true

  mount_uploader :avatar, AvatarUploader 

  def should_generate_new_friendly_id?
    new_record?
  end

end