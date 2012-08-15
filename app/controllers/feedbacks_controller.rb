class FeedbacksController < ApplicationController

  def new
    @feedback = Feedback.new

    respond_to do |format|
      format.html
    end
  end

  def problem
    @feedback = Feedback.new

    respond_to do |format|
      format.html
    end  
  end  

  def create
    @feedback = Feedback.new(params[:feedback])
    if current_user
      @feedback.creator = current_user
    end
    @feedback.save

    respond_to do |format|
      if @feedback.save
        flash[:notice] = 'Thank you!'        
        format.html{redirect_to root_path}
      else
        flash[:notice] = "Error sending your feedback"        
        format.html{redirect_to :action => 'new'}        
      end
    end
  end

end
