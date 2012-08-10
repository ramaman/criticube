class Analytics

  ## KissMetrics API

  def self.km_on_cube(cur_user, cube)
    unless cur_user.cc_team == true
      # Use KM API to record cube with cube_id and cube pagename as properties

    end
  end

  def self.km_on_user(cur_user, user)
    unless cur_user.cc_team == true
      # Use KM API to record cube with user_id and user pagename as properties

    end
  end

  def self.km_on_post(cur_user, post)
    unless cur_user.cc_team == true
      # Use KM API to record cube with post_id propery

    end
  end

end