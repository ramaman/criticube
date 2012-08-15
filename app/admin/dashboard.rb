ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  
  section "Stats", :priority => 1 do
    @users_count = User.count
    @cubes_count = Cube.count
    @posts_count = Post.count    

    div do
      render 'stats', { 
        :users_count => @users_count,
        :cubes_count => @cubes_count,
        :posts_count => @posts_count        
        }
    end
  end

  section "Recent Users", :priority => 2 do
    ul do
      User.order('created_at DESC').limit(5).collect do |user|
        li link_to(user.fast_name, admin_user_path(user)) + " - " + link_to('profile', vanity_path(user))
      end
    end
  end

  section "Recent Cubes", :priority => 3 do
    ul do
      Cube.order('created_at DESC').limit(5).collect do |cube|
        li link_to(cube.name, admin_cube_path(cube)) + " - " + link_to('page', vanity_path(cube))
      end
    end
  end

  # section "Recent Posts", :priority => 3 do
  #   ul do
  #     Post.order('created_at DESC').limit(5).collect do |post|
  #       li link_to(post.headline, admin_post_path(post)) + " - " + link_to('page', vanity_post_path(post.parent, post))
  #     end
  #   end
  # end

  # section "Recent Flags", :priority => 3 do
  #   ul do
  #     Flagging.order('created_at DESC').limit(5).collect do |flagging|
  #       li link_to("#{flagging.flagger.fast_name} - #{flagging.reason}", admin_flagging_path(flagging))
  #     end
  #   end
  # end
  
  section "Recent Feedbacks", :priority => 3 do
    ul do
      Feedback.order('created_at DESC').limit(5).collect do |feedback|
        li link_to("#{feedback.creator ? feedback.creator.fast_name : 'Anonymous' } - #{short_string(feedback.content, 100)}", admin_feedback_path(feedback))
      end
    end
  end

  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.
  
  # == Conditionally Display
  # Provide a method name or Proc object to conditionally render a section at run time.
  #
  # section "Membership Summary", :if => :memberships_enabled?
  # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }

end
