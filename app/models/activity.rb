class Activity < ActiveRecord::Base
  
  actions = ['followed', 'created', 'updated']

  attr_accessible :actor,
                  :actor_id,
                  :action,
                  :primary_objekt,
                  :secondary_objekt,
                  :tertiary_objekt,
                  :primary_objekt_type,
                  :primary_objekt_id,
                  :secondary_objekt_type,
                  :secondary_objekt_id,
                  :tertiary_objekt_type,
                  :tertiary_objekt_id,
                  :archived

  belongs_to  :actor,
              :class_name => 'User',
              :foreign_key => 'actor_id'

  belongs_to  :primary_objekt,
              :polymorphic => true

  belongs_to  :secondary_objekt,
              :polymorphic => true
              
  belongs_to  :tertiary_objekt,
              :polymorphic => true                            

  has_many  :notifications,
            :dependent => :destroy

  validates   :action,
              :inclusion => { :in => actions, :message => "is not supported" }
              
  scope :clean, where{ |a|
    a.archived == nil    
  }

  def action_story
    if self.action == 'created'
      'posted'
    else
      self.action
    end
  end
  
  def set_as_archived
    self.archived = true
    self.save
  end
  
  def send_notifications
    # Those who follow actor and secondary_objekt should get notification
    subscriber_ids = []
      
    if secondary = self.secondary_objekt
    
    end
        
  end
   

end