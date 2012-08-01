class Notification < ActiveRecord::Base

  belongs_to :activity
  belongs_to :user

  after_save :update_notification_count

  scope :read, where{ |a|
    a.read == true
  }

  scope :unread, where{ |a|
    a.read == nil
  }  

  def update_notification_count
    u = self.user
    u.notifications_count = u.notifications.where{ read == nil }.count
    u.save
  end

  handle_asynchronously :update_notification_count

end
