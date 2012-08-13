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

  def explore

    if !params[:topic_id] || params[:topic_id] == 'all'

      @cubes = Cube.order('RANDOM()').page(params[:page]).per(25)
      @featured_cubes = Cube.featured.order("RANDOM()")

    elsif params[:topic_id] == 'latest'
    
      @cubes = Cube.order('created_at DESC').page(params[:page]).per(25)

    else
      
      @cubes = Topic.find(params[:topic_id]).cubes.page(params[:page]).per(25)

    end

    if session[:signup]
      # IMPORTANT to fire analytics event 'signup' to kissmetrics
      @km_special = 'signup' 
      session[:signup] = nil
    end

    @km_event = 'On Cube'

    respond_to do |format|
      format.html
    end    
  end


end