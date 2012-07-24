module FollowagesHelper

  def follow_button(object)
    if !user_signed_in?
      link_to(
        "Follow #{object.class}", 
        new_user_session_path,
        :class => ['btn', 'btn-success', 'core', 'ajax-loading']
      )
    else    
      followage = current_user.following?(object)
      if !followage
        link_to(
          "Follow #{object.class}", 
          followages_path(:followage => {:followed_id => object.id, :followed_type => object.class.to_s}),
          :method => :post,
          :remote => :true,
          :class => ['btn', 'btn-success', 'core', 'ajax-loading'],
          :data => {'loading-text' => 'Following...', 'error-text' => 'Error', 'ori-text' => "Follow #{object.class}"}
        )
      else
        link_to(
          "Unfollow #{object.class}", 
          followage_path(followage),
          :method => :delete,
          :remote => :true, 
          :class => ['btn', 'ajax-loading'],
          :data => {'loading-text' => 'Unfollowing...', 'error-text' => 'Error', 'ori-text' => "Unfollow #{object.class}"}
        )
      end
    end  
  end

end
