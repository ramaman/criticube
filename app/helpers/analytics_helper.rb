module AnalyticsHelper

  def google_analytics_id
    if Rails.env.production?
      "UA-20803740-1"
    else
      "UA-33989219-1"
    end
  end

  def google_analytics_domain
    if Rails.env.production?
      "www.criticube.com"
    else
      "stage-july14.herokuapp.com"
    end
  end

  def km_api_key
    if Rails.env.production?
      "'d0dc29f9754cd374358c0b6c79c3c7fc5676b232'"
    else
      "'a4a1c421ff2bc95f6555451a2f98c28770795fb2'"
    end    
  end

end
