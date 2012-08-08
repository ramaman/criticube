class Analytics

  if Rails.env.production?
    @gabba = Gabba::Gabba.new("UA-20803740-1", "criticube.com")
  else
    @gabba = Gabba::Gabba.new("UA-33989219-1", "stage-july14.herokuapp.com")  
  end  

  def self.record_signup(provider)
    # provider must include 'native', 'facebook'
    @gabba.event("Users", "signup", "provider", provider, true)
  end

end