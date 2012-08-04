class VotesController < ApplicationController

  before_filter :authenticate_user!

  def create
    if params[:vote] && (['User','Cube', 'Post'].include?(params[:vote][:voteable_type]))
      @parent = Object.const_get(params[:vote][:voteable_type]).find(params[:vote][:voteable_id])
      current_user.vote!(@parent, params[:vote][:direction])

    end
    
    respond_to do |format|
      format.html { redirect_to @parent }
      format.js { render :layout => false }
    end    
  end

  def destroy
    vote = RSEvaluation.find(params[:id])
    @parent = @vote.target
    current_user.unvote!(@parent)
    

    respond_to do |format|
      format.html { redirect_to @parent }
      format.js { render :layout => false }
    end
  end

  private

  def parent_object
    v = Vanity.find(params[:id])
    return v.owner
  end  

end