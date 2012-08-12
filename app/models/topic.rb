class Topic < ActiveRecord::Base

  extend FriendlyId

  friendly_id :name, :use => :slugged

  attr_accessible :name, :description, :avatar

  belongs_to  :creator,
              :class_name => 'User',
              :foreign_key => 'creator_id'  

  has_many  :cubes,
            :dependent => :nullify

  validates :name,
            :presence => true,
            :uniqueness => true

  mount_uploader :avatar, AvatarUploader 

  def permalink
    Rails.application.routes.url_helpers.topic_path(self)
  end

  def url
    self.permalink
  end

  def follow_permalink
    Rails.application.routes.url_helpers.topic_follow_path(self)
  end  

  def unfollow_permalink
    Rails.application.routes.url_helpers.topic_unfollow_path(self)
  end


  def should_generate_new_friendly_id?
    new_record?
  end

end