class Notifier < ActionMailer::Base
  default from: "\"Criticube Notifier\" <notifications@criticube.com>"

  def inform_follow_user(notification)
    @notification = notification
    mail(
      :to => @notification.user.email, 
      :subject => "#{@notification.user.first_name}, you have a new follower on Criticube"
      )
  end

end
