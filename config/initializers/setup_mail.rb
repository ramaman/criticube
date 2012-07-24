if Rails.env.development?

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "criticube.com",
    :user_name            => "development@criticube.com",
    :password             => "DoraemonMailer2011!",
    :authentication       => "plain",
    :enable_starttls_auto => true
  }  
  ActionMailer::Base.default_url_options[:host] = "criticube.com"

else

  # Change this with sendgrid creds

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "criticube.com",
    :user_name            => "development@criticube.com",
    :password             => "DoraemonMailer2011!",
    :authentication       => "plain",
    :enable_starttls_auto => true
  }  
  ActionMailer::Base.default_url_options[:host] = "criticube.com"

end
# Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?