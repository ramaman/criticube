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
    redirect_to explore_topic_path(@topic)

    # respond_to do |format|
    #   format.html
    #   # format.js { render :layout => false }
    # end
  end


end