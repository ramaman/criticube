module FollowagesHelper

  def follow_button(object)
    if !user_signed_in?
      link_to(
        "Follow #{object.story_name}", 
        new_user_session_path,
        :class => ['btn', 'btn-success', 'core', 'ajax-loading']
      )
    else    
      followage = current_user.following?(object)
      if !followage
        link_to(
          "Follow #{object.story_name}", 
          object.follow_permalink,
          :method => :post,
          :remote => :true,
          :class => ['btn', 'btn-success', 'core', 'ajax-loading'],
          :data => {'loading-text' => 'Following...', 'error-text' => 'Error', 'ori-text' => "Follow #{object.class}"}
        )
      else
        link_to(
          "Unfollow #{object.story_name}", 
          object.unfollow_permalink,
          :method => :delete,
          :remote => :true, 
          :class => ['btn', 'ajax-loading'],
          :data => {'loading-text' => 'Unfollowing...', 'error-text' => 'Error', 'ori-text' => "Unfollow #{object.class}"}
        )
      end
    end  
  end

  def follow_link(object)
    if !user_signed_in?
      link_to(
        "Follow #{custom_follow_name(object)}", 
        new_user_session_path
      )
    else    
      followage = current_user.following?(object)
      if !followage
        link_to(
          "Follow #{custom_follow_name(object)}", 
          object.follow_permalink,
          :method => :post,
          :remote => :true
        )
      else
        link_to(
          "Unfollow #{custom_follow_name(object)}", 
          object.unfollow_permalink,
          :method => :delete,
          :remote => :true, 
          :class => 'blend'
        )
      end
    end  
  end

  def custom_follow_name(object)
    if object.class == User
      object.first_name
    else
      object.story_name  
    end
  end

end
