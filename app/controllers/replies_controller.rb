class RepliesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :initialize_variables, :except => [:create]
  before_filter :moderator_check, :only => :destroy

  def create
    @cube ||= Cube.find(params[:vanity_id])
    @post ||= @cube.posts.find(params[:post_id])    
    @reply = Reply.new(reply_params)
    @reply.container = @post
    @reply.creator = current_user
    if params[:reply][:parent_id] && !params[:reply][:parent_id].blank? # ADD CHECK IF REPLY IS INSIDE THE CUBE && @cube.replies.find(params[:reply][:parent_id])
      @reply.parent_id = params[:reply][:parent_id]
    end
    @reply.save

    respond_to do |format|
      if @reply.save
        format.html {redirect_to vanity_post_path(@post.parent, @post)}
        format.js {:layout => false}
      else
        flash[:notice] = 'Error posting reply'
        format.html {redirect_to vanity_post_path(@post.parent, @post)}
      end  
    end
  end

  def destroy

  end

  private

  def reply_params
    params[:reply].slice(:content, :tipe)
  end

  def moderator_check
    unless (@post.creator == current_user) || (@parent.managers.include?(current_user))
      raise ActionController::RoutingError.new('Not Found')
    end  
  end

  def initialize_variables
    @cube ||= Cube.find(params[:vanity_id])
    @post ||= @cube.posts.find(params[:post_id])
    @reply ||= @post.replies.find(params[:id])
  end

end