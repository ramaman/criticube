class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  include Devise::Controllers::Rememberable

  def facebook
    omniauth_hash = request.env["omniauth.auth"]
    user = User.from_facebook(omniauth_hash)

    if user_signed_in?
      ## Add Facebook to current user
      if user.persisted? && user != current_user
        flash[:notice] = 'The currently logged on Facebook account is connected to another Criticube account'
        redirect_to edit_user_registration_path
      else
        current_user.create_facebook_auth(omniauth_hash)
        redirect_to edit_user_registration_path
      end  
    else
      user = User.from_facebook(omniauth_hash)
      if user.persisted?
        remember_me user
        sign_in_and_redirect user
      else
        ## Prepare new user registration
        session["devise.omniauth_attributes"] = user.attributes
        session["devise.omniauth_attributes"]["provider"] = omniauth_hash['provider']
        session["devise.omniauth_attributes"]["uid"] = omniauth_hash['uid']
        session["devise.omniauth_attributes"]["token"] = omniauth_hash['credentials']['token']
        session["devise.omniauth_attributes"]["token_expires_at"] = omniauth_hash['credentials']['expires_at']
        redirect_to new_facebook_user_registration_path
      end
    end  
  end

end