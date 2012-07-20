class AuthenticationsController < ApplicationController

  before_filter :authenticate_user!

  def destroy
    if params[:provider] == 'facebook'
      auth = current_user.facebook_auth
      auth.destroy
      if auth.destroy
        flash[:notice] = "You have successfully disconnected your Facebook account"
      else
        flash[:notice] = "Error disconnecting from Facebook"
      end
      redirect_to edit_user_registration_path
    end
  end

end