class VotesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :parent_object

  def vote
    current_user.vote(@parent, params[:direction])
    
    respond_to do |format|
      format.html { redirect_to @parent }
      format.js { render :layout => false }
    end    
  end

  def unvote
    current_user.unvote(@parent)

    respond_to do |format|
      format.html { redirect_to @parent }
      format.js { render :layout => false }
    end
  end

  private

  def parent_object
    if params[:reply_id]
      @parent ||= Vanity.find(params[:vanity_id]).owner.posts.find(params[:post_id]).replies.find(params[:reply_id])
    elsif params[:post_id]
      @parent ||= Vanity.find(params[:vanity_id]).owner.posts.find(params[:post_id])
    end
  end  

end