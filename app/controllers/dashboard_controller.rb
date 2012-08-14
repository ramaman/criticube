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

    @topics = Topic.all

    if params[:language]
      language_request = params[:language].capitalize
    else
      language_request = 'English'
    end

    if !params[:topic_id] || params[:topic_id] == 'all'

      @cubes = Cube.where{language == language_request}.order('RANDOM()').page(params[:page]).per(25)
      @featured_cubes = Cube.featured.order("RANDOM()")
      @header = 'All Cubes'
      # @language_filter_url = explore_topic_language_path('latest',language_request)

    elsif params[:topic_id] == 'latest'
    
      @cubes = Cube.where{language == language_request}.order('created_at DESC').page(params[:page]).per(25)
      @header = 'Latest Cubes'
      # @language_filter_url = explore_topic_language_path('latest',language_request)

    else
      topic = Topic.find(params[:topic_id])
      @cubes = Topic.find(params[:topic_id]).cubes.page(params[:page]).per(25)
      @header = topic.name
      # @language_filter_url = explore_topic_language_path(topic, language_request)

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