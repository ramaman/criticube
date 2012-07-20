class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  include Devise::Controllers::Rememberable

  def facebook
    omniauth_hash = request.env["omniauth.auth"]
    user = User.from_facebook(omniauth_hash)
    if user.persisted?
      sign_in_and_redirect user
    else
      session["devise.omniauth_attributes"] = user.attributes
      session["devise.omniauth_attributes"]["provider"] = omniauth_hash['provider']
      session["devise.omniauth_attributes"]["uid"] = omniauth_hash['uid']
      session["devise.omniauth_attributes"]["token"] = omniauth_hash['credentials']['token']
      session["devise.omniauth_attributes"]["token_expires_at"] = omniauth_hash['credentials']['expires_at']
      redirect_to new_facebook_user_registration_path
    end
  end

end