class CubesController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  def index
    @cubes = User.order("RANDOM()").page(params[:page]).per(50)
    respond_to :html
  end

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end



end