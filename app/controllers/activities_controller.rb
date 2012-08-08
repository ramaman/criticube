class ActivitiesController < ApplicationController

  def index
    @parent = parent_object
    @activities = @parent.feed.clean.page(params[:page]).per(12)
    respond_to do |format|
      format.html
      # format.js { render :layout => false }
    end
  end

  private

  def parent_object
    v = Vanity.find(params[:vanity_id])
    return v.owner
  end  

end