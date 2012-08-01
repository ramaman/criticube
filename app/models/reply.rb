class Reply < ActiveRecord::Base

  has_ancestry

  tipes = ['neutral', 'support', 'challenge']

  attr_accessible :content,
                  :container_id,
                  :container_type,
                  :tipe

  belongs_to  :creator, 
              :class_name => 'User',
              :foreign_key => 'creator_id'

  belongs_to  :container,
              :polymorphic => true                        

  validates :tipe,
            :inclusion => {:in => tipes, :message => "is not supported" }

  validates :content,
            :length => { :maximum => 3550} 

  has_many  :primary_activity_objekt,
            :class_name => 'Activity',
            :as => :primary_objekt,
            :dependent => :destroy
            
  has_many  :secondary_activity_objekt,
            :class_name => 'Activity',
            :as => :secondary_objekt,
            :dependent => :destroy             
            
  default_scope includes(:container)                       

  def dynamic_permalink
    Rails.application.routes.url_helpers.vanity_post_path(self.container.parent, self.container) + "#reply_#{self.id}"
  end

  def name
    if self.content.length < 150
      self.content[0..150]
    else
      self.content[0..150] + '...'
    end
  end

  def tipe_name
    'a reply'
  end  

end
