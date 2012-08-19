class Notification < ActiveRecord::Base

  belongs_to :activity
  belongs_to :user

  validates :activity, :presence => true
  validates :user, :presence => true

  scope :read, where{ |a|
    a.read == true
  }

  scope :unread, where{ |a|
    a.read == false
  }  

  after_save :update_notification_count, :send_email

  def mark_as_read
    self.read = true
    self.save
  end

  def update_notification_count
    u = self.user
    u.notifications_count = u.notifications.where{ read == false }.count
    u.save
  end

  def send_email
    if self.activity.action == 'followed'
      if (self.activity.primary_objekt_type == 'User') && (self.activity.primary_objekt.subscribe_follow_self == true)
        ActionMailer::Base::Notifier.delay.inform_follow_user(self)
      end 
    end
  end

  handle_asynchronously :send_email

end
