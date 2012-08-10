class CubesController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show, :admins]
  before_filter :manager_check, :except => [:index, :show, :admins, :new, :create]

  def index
    @featured_cubes = Cube.featured.order("RANDOM()").page(params[:page]).per(50)
    @cubes = Cube.common.order("RANDOM()").page(params[:page]).per(20)
    
    @km_event = 'On Cube explorer'
    
    if session[:signup]
      # IMPORTANT to fire analytics event 'signup' to kissmetrics
      @km_special = 'signup' 
      session[:signup] = nil
    end
      
    respond_to :html
  end

  def show
    @cube = Cube.find(params[:id])
    @posts = @cube.posts.order('created_at DESC').page(params[:page]).per(25)
    @activities = @cube.feed.limit(10)
    @title = @cube.name
    @special_image = @cube.avatar_url
    @km_event = 'On Cube'
    respond_to :html
  end

  def admins
    @cube = Cube.find(params[:id])
    @managers = @cube.managers.page(params[:page]).per(3)
    respond_to :html
  end

  def new
    @cube = Cube.new
    @cube.build_vanity
    respond_to :html
  end

  def create
    @cube = Cube.new(cube_params)
    @cube.language = params[:cube][:language]
    @cube.vanity = Vanity.new_from_name(params[:cube][:vanity_attributes][:name])  
    @cube.creator = current_user  
    @cube.assign_manager(current_user)
    @cube.save
    current_user.follow!(@cube)
    current_user.record_create(@cube)
    if @cube.save
      redirect_to vanity_path(@cube)
    else
      render :new
    end
  end

  def add_member

  end

  def remove_member

  end

  def edit
    respond_to :html
  end

  def update
    @cube.update_attributes(cube_params)
    respond_to do |format|
      if @cube.save
        flash[:notice] = 'Cube has been successfully updated'
        format.html {redirect_to vanity_path(@cube)}
      else
        format.html {redirect_to @cube.permalink}
      end  
    end
  end

  def destroy
    @cube = Cube.find(params[:id])
    @cube.destroy
    if @cube.destroy      
      flash[:notice] = 'Cube has been successfully deleted'
      redirect_to root_path
    else
      flash[:alert] = 'Error deleting cube'
      redirect_to vanity_path(@cube)
    end
  end

  private

  def cube_params
    params[:cube].slice(:name, :description, :avatar)
  end

  def manager_check
    @cube = Cube.find(params[:id])
    unless @cube.managers.include?(current_user)
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end