class CubesController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @cubes = Cube.order("RANDOM()").page(params[:page]).per(50)
    respond_to :html
  end

  def show
    @cube = Cube.find(params[:id])
    respond_to :html
  end

  def new
    @cube = Cube.new
    @cube.build_vanity
    respond_to :html
  end

  def create
    @cube = Cube.new(cube_params)
    @cube.vanity = Vanity.new_from_name(params[:cube][:vanity_attributes][:name])    
    @cube.assign_manager(current_user)
    @cube.save
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

  end

  def update

  end

  def destroy

  end

  private

  def cube_params
    params[:cube].slice(:name, :description, :language)
  end

end