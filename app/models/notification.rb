class Notification < ActiveRecord::Base

  belongs_to :activity
  belongs_to :user

  after_save :update_notification_count

  validates :activity, :presence => true
  validates :user, :presence => true

  scope :read, where{ |a|
    a.read == true
  }

  scope :unread, where{ |a|
    a.read == false
  }  

  def mark_as_read
    self.read = true
    self.save
  end

  def update_notification_count
    u = self.user
    u.notifications_count = u.notifications.where{ read == false }.count
    u.save
  end

end
