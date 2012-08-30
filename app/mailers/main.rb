class Main < ActionMailer::Base
  # default from: "\"Criticube Messenger\" <mailer@criticube.com>"

  def welcome(recipient)
    @recipient = recipient
    mail(from: "\"Titus van der Spek\" <titus.vanderspek@criticube.com>", :to => @recipient.email, :subject => "How to get the most out of Criticube")
  end  
  
end
