class Authentication < ActiveRecord::Base

  attr_accessible = nil

  validates :user_id,
            :presence => true
  validates :uid,
            :presence => true
  validates :provider,
            :presence => true
  # validates :token,
  #           :presence => true

  belongs_to :user

  def profile_page
    if self.provider == 'facebook'
      'http://www.facebook.com/' + self.uid
    end
  end

  def profile_picture_url(options={})
    if self.provider == 'facebook'
      if options[:size]
        "https://graph.facebook.com/#{self.uid}/picture?type=#{options[:size]}"
      else
        "https://graph.facebook.com/#{self.uid}/picture"
      end
    end
  end

  def token_valid?
    if (self.provider == 'facebook') && self.token_expires_at
      self.token_expires_at > Time.now.to_i ? true : false
    end
  end

  def update_token(omniauth_callback)
    # if (self.provider == 'facebook')
    self.token = omniauth_callback['credentials']['token']
    self.token_expires_at = omniauth_callback['credentials']['expires_at']
    # end
  end
  
end