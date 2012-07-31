class RepliesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :initialize_variables, :except => [:create]
  before_filter :moderator_check, :only => :destroy

  def show
    respond_to :html
  end

  def create
    @cube ||= Cube.find(params[:vanity_id])
    @post ||= @cube.posts.find(params[:post_id])    
    @reply = Reply.new(reply_params)
    @reply.container = @post
    @reply.creator = current_user
    if params[:reply][:parent_id] && !params[:reply][:parent_id].blank? # ADD CHECK IF REPLY IS INSIDE THE CUBE && @cube.replies.find(params[:reply][:parent_id])
      @reply.parent_id = params[:reply][:parent_id]
      @root = 'Reply_' + @reply.root.id.to_s
    else
      @root = ''
    end

    @reply.save

    respond_to do |format|
      if @reply.save
        format.html {redirect_to vanity_post_path(@post.parent, @post)}
        format.js {render :layout => false}
      else
        flash[:notice] = 'Error posting reply'
        format.html {redirect_to vanity_post_path(@post.parent, @post)}
      end  
    end
  end

  def destroy
    @destroyed_id = @reply.id
    @reply.destroy
    respond_to do |format|
      if @reply.destroy
        format.html {redirect_to vanity_post_path(@post.parent, @post)}
        format.js {render :layout => false}
      else
        flash[:notice] = 'Error posting reply'
        format.html {redirect_to vanity_post_path(@post.parent, @post)}
      end  
    end    
  end

  private

  def reply_params
    params[:reply].slice(:content, :tipe)
  end

  def moderator_check
    unless (@reply.creator == current_user) || (@cube.managers.include?(current_user))
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def initialize_variables
    @cube ||= Cube.find(params[:vanity_id])
    @post ||= @cube.posts.find(params[:post_id])
    @reply ||= @post.replies.find(params[:id])
  end

end