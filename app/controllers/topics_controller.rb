class TopicsController < ApplicationController

  def index
    @topics = Topic.all
    respond_to do |format|
      format.html
      # format.js { render :layout => false }
    end    
  end

  def show
    @topic = Topic.find(params[:id])

    respond_to do |format|
      format.html
      # format.js { render :layout => false }
    end
  end


end