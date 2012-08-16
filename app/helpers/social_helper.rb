module SocialHelper

  def tweet
    if @share_title
      tweet = short_string(@share_title, 100)
    else
      if @title.nil?
        tweet = "I just found an interesting page"
      else
        tweet = short_string(@title, 100)
      end
    end
    return tweet
  end 

end