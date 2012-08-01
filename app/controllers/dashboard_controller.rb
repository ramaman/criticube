class DashboardController < ApplicationController

  def home
    if user_signed_in?
      @feed = current_user.dashboard_feed
    end

    respond_to do |format|
      format.html
    end    
  end

end