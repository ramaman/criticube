class DashboardController < ApplicationController

  before_filter :authenticate_user!, :except => [:home]

  def home
    if user_signed_in?
      @km_event = 'On Dashboard'
      @activities = current_user.dashboard_feed.page(params[:page]).per(25)
    else
      # @km_event = 'On Gate'
      @special_page = true  
    end

    respond_to do |format|
      format.html
    end    
  end

  def feed
    if params[:tipe]

    else
      @activities = current_user.dashboard_feed.page(params[:page]).per(25)
    end

    respond_to do |format|
      format.json
    end    
  end

end