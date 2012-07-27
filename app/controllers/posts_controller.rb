class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :editor_check, :only => [:edit, :update]
  before_filter :moderator_check, :only => [:destroy]


  def create
    @parent = params[:post][:parent_type].constantize.find(params[:post][:parent_id])
    @post = Post.new(new_post_params)
    @post.parent = @parent
    @post.creator = current_user
    @post.save!
    if @post.save
      redirect_to vanity_post_path(@parent, @post)
    else
      flash[:alert] = 'Error posting'
      redirect_to vanity_path(@parent)
    end

  end

  def show
    @post = Post.find(params[:id])
    @title = @post.headline
    respond_to :html
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def post_params
    params[:post].slice(:headline, :content)    
  end

  def new_post_params
    params[:post].slice(:tipe, :headline, :content)
  end

  def editor_check
    # Only post creator can be editor, he/she can delete and edit own posts
    @post = Post.find(params[:id])
    unless @post.creator == current_user
      raise ActionController::RoutingError.new('Not Found')
    end    
  end

  def moderator_check
    # Moderators can delete posts, but not edit

  end

end