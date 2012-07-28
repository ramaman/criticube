module FacebookHelper

  def fb_thumb_link(uid)
    "http://graph.facebook.com/#{uid}/picture?type=square"
  end

  def fb_thumb(uid)
    image_tag(fb_thumb_link(uid))
  end

  def fb_profile_url(uid)
    "https://www.facebook.com/#{uid}"
  end

  def fb_app_id
    if Rails.env.production?
      '171274556257581'
    elsif Rails.env.staging?
      '174221455964328'
    else
      '219593544829191'
    end
  end

end
