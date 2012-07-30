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
            
  default_scope includes(:container)                       

  def dynamic_permalink
    Rails.application.routes.url_helpers.vanity_post_path(self.container.parent, self.container) + "#reply_#{self.id}"
  end

end
