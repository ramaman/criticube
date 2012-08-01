module NotificationsHelper

  def notification_read_button(notification)
    if notification.read == false 
      link_to 'Mark as read', notification_path(notification), :method => :delete, :class => 'btn btn-mini right', :remote => true
    end
  end

end
