module MessagesHelper

  def messages_link(user)
    if user.unread_messages_count && (user.unread_messages_count > 0)
      link_to "Messages (#{user.unread_messages_count})", messages_path, :class => 'text core'
    else
      link_to "Messages", messages_path, :class => 'text'
    end
  end
end
