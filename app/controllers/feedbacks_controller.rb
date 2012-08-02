class FeedbacksController < ApplicationController

  before_filter :authenticate_user!

  def new
    @feedback = Feedback.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    @feedback.creator = current_user
    @feedback.save

    respond_to do |format|
      if @feedback.save
        flash[:notice] = 'Your feedback has been sent'        
        format.html{redirect_to root_path}
      else
        flash[:notice] = "Error sending your feedback"        
        format.html{redirect_to :action => 'new'}        
      end
    end
  end

end
