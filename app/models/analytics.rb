class Analytics

  ## KissMetrics API

  # View metrics are tracked by javascript fired events

  def self.km_on_cube(cur_user, cube)
    unless cur_user.cc_team == true
      # Use KM API to record cube with cube_id, cube pagename, and cube name as properties
      "_kmq.push(['record', 'On Cube', {'id':'#{cube.id}', 'name':'#{cube.name}', 'page_name':'#{cube.page_name}'}]);"
    end
  end

  def self.km_on_user(cur_user, user)
    unless cur_user.cc_team == true
      # Use KM API to record cube with user_id and user pagename as properties
      "_kmq.push(['record', 'On User', {'id':'#{user.id}', 'page_name':'#{user.page_name}'}]);"
    end
  end

  def self.km_on_post(cur_user, post)
    unless cur_user.cc_team == true
      # Use KM API to record cube with post_id property
      "_kmq.push(['record', 'On Post', {'id':'#{post.id}', 'name':'#{post.name}'}]);"
    end
  end

  # Follow metrics are tracked by server fired events

  def self.km_follow_cube(cur_user, cube)
    unless cur_user.cc_team == true

    end
  end

  def self.km_follow_user(cur_user, user)
    unless cur_user.cc_team == true

    end
  end

  def self.km_follow_post(cur_user, post)
    unless cur_user.cc_team == true

    end
  end  

  # Create metrics are tracked by server fired events

  def self.km_created_cube(cur_user, cube)
    unless cur_user.cc_team == true
      DelayedKiss.record(cur_user.id, 'Created cube')#, 
        # :id => cube.id, 
        # :page_name => cube.page_name, 
        # :name => cube.name
        # )
    end
  end

  def self.km_created_post(cur_user, post)
    unless cur_user.cc_team == true

    end
  end
  
  def self.km_created_reply(cur_user, reply)
    unless cur_user.cc_team == true

    end
  end

end