module RepliesHelper

  def reply_tipe_label(reply)
    if reply.tipe == 'neutral'
      label_tipe = 'cclink'
    elsif reply.tipe == 'support'
      label_tipe = 'success'
    elsif reply.tipe == 'challenge'
      label_tipe = 'important'
    end
    content_tag(:span, :class => "label label-#{label_tipe}") do 
      reply.tipe.capitalize
    end    
  end

end
