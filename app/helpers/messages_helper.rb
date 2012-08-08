module MessagesHelper

  def message_title(user)
    if user.unread_message_count && (user.unread_message_count > 0)
      "Messages (#{user.unread_messages_count})"
    else
      "Messages"
    end
  end
end
