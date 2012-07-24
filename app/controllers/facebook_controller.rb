class FacebookController < ApplicationController

  before_filter :authenticate_user!

  def import_picture
    auth = current_user.facebook_auth
    # graph = Koala::Facebook::API.new(auth.token)
    # current_user.remote_avatar_url = graph.get_picture(auth.uid, :type => 'large')
    # current_user.save

    current_user.import_facebook_picture

    respond_to do |format|
      flash[:notice] = 'Your profile has been successfully updated'
      format.html {redirect_to vanity_path(current_user)}
    end
  end


end