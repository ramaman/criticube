class Message < ActiveRecord::Base

  attr_accessible :body, :read, :recipient_id

  belongs_to  :sender, 
              :class_name => 'User',
              :foreign_key => 'sender_id'

  belongs_to  :recipient, 
              :class_name => 'User',
              :foreign_key => 'recipient_id'

  validates   :body,
              :presence => true,
              :length => {:maximum => 10000}
              
  validates   :sender_id, :presence => true
  validates   :recipient_id, :presence => true  

  after_create :email_recipient, :increment_recipient_counter_cache
  
  def mark_as_read
    r = self.recipient
    self.read = true
    self.save
    r.unread_messages_count = r.unread_messages.count
    r.save
  end

  private

  def email_recipient
    if self.recipient.subscribe_messages == true
      # Release pigeons
      ActionMailer::Base::Messenger.delay.inform_message(self)
    end
  end
  
  def increment_recipient_counter_cache
    r = self.recipient
    r.unread_messages_count = r.unread_messages.count
    r.save    
  end          

end
