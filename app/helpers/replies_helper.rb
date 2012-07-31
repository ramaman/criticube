module RepliesHelper

  def reply_tipe_label(reply, options={})
    if reply.tipe == 'neutral'
      label_tipe = 'cclink'
    elsif reply.tipe == 'support'
      label_tipe = 'success'
    elsif reply.tipe == 'challenge'
      label_tipe = 'important'
    end
    content_tag(:span, :class => "label label-#{label_tipe} #{options[:class]}") do 
      reply.tipe.capitalize
    end    
  end

  def reply_actions_tab(reply)
    [
      reply_actions_reply_link(reply)
    ].join(' ').html_safe
  end

  def reply_actions_reply_link(reply)
    if user_signed_in?
      link_to 'Reply', "#reply_replies_form_#{reply.id}", :class => 'sat-switch reply-to',:data => {"cmf-tag" => "reply_replies_#{reply.id}", "sat-tag" => "reply_replies_#{reply.id}"}
    else
      link_to 'Reply', new_user_session_path
    end      
  end


end
