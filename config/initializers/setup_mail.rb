if Rails.env.development?

  # ActionMailer::Base.delivery_method = :smtp
  # ActionMailer::Base.smtp_settings = {
  #   :address              => "smtp.gmail.com",
  #   :port                 => 587,
  #   :domain               => "criticube.com",
  #   :user_name            => "development@criticube.com",
  #   :password             => "DoraemonMailer2011!",
  #   :authentication       => "plain",
  #   :enable_starttls_auto => true
  # }  
  # ActionMailer::Base.default_url_options[:host] = "criticube.com"

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address              => "email-smtp.us-east-1.amazonaws.com",
    :port                 => 25,
    :domain               => "criticube.com",
    :user_name            => "AKIAIQSW7ZVYVWFZHXYA",
    :password             => "As+3Bt9vpmmHhTq3hjQGsfKdPa6dlz47GiZjDVnAhQmv",
    :authentication       => "plain",
    :enable_starttls_auto => true
  }  
  ActionMailer::Base.default_url_options[:host] = "criticube.com"

else

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.mandrillapp.com",
    :port                 => 587,
    :domain               => "criticube.com",
    :user_name            => "ramaman",
    :password             => "5d367983-e148-49c2-8758-bc3b91425670",
    :authentication       => "plain",
    :enable_starttls_auto => true
  }  
  ActionMailer::Base.default_url_options[:host] = "criticube.com"

end
# Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?