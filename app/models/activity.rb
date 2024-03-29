class Activity < ActiveRecord::Base
  
  actions = ['followed', 'created', 'updated', 'liked']

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
              
  after_save :send_notifications

  scope :clean, where{ |a|
    a.archived == nil    
  }

  default_scope includes(:actor, :primary_objekt, :secondary_objekt, :tertiary_objekt)

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

  def check_duplicates
    Activity.where{ |a|
      (a.id != self.id) & 
      (a.action == self.action) & (a.actor_id == self.actor_id) &
      (a.primary_objekt_type == self.primary_objekt_type) &
      (a.primary_objekt_id == self.primary_objekt_id)
    }
  end
  
  def send_notifications
    # Those who follow primary_objekt and secondary_objekt should get notification
    subscriber_ids = []

    # Add followers of Actor    
    # subscriber_ids += self.actor.reverse_followages.collect{|f| f.follower_id}
    if ((self.action == 'followed') || (self.action == 'liked')) && (self.check_duplicates.length == 0)
      # Add followed user to subscriber
      if self.primary_objekt_type == 'User'
        subscriber_ids << self.primary_objekt_id
      elsif self.primary_objekt_type == 'Cube'
        subscriber_ids += self.primary_objekt.roles.collect{|r| r.owner_id}  
      elsif (self.primary_objekt_type == 'Post') || self.primary_objekt_type == 'Reply'
        subscriber_ids << self.primary_objekt.creator_id
      end
    end
       
    if self.secondary_objekt
      secondary = self.secondary_objekt
      # Add followers of Cube or Post
      if (secondary.class == Cube) || (secondary.class == Post)
        secondary.reverse_followages.collect{|f| f.follower_id}
        secondary.reverse_followages.each do |f|
          subscriber_ids << f.follower_id unless f.follower_id == self.actor_id 
        end
      end
    end

    subscriber_ids.uniq.each do |subscriber_id|
      n = Notification.new
      n.user_id = subscriber_id
      n.activity_id = self.id
      n.save
    end

    # return subscriber_ids

  end

  # handle_asynchronously :send_notifications

end