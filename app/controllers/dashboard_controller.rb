class DashboardController < ApplicationController

  def home
    if user_signed_in?
      @feed = current_user.dashboard_feed.page(params[:page]).per(25)
    end

    respond_to do |format|
      format.html
    end    
  end

end