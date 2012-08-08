class Messenger < ActionMailer::Base
  default from: "messenger@criticube.com"

  def inform_message(message)
    @message = message
    mail(:to => @message.recipient.email, :subject => "#{@message.sender.fast_name} sent you a message")
  end  
end
