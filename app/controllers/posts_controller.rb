class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :editor_check, :only => [:edit, :update]
  before_filter :moderator_check, :only => [:destroy]


  def index
    @parent = parent_object
    if @parent.class == Cube
      @posts = @parent.posts.page(params[:page]).per(20)
    elsif @parent.class == User 
      @posts = @parent.created_posts.page(params[:page]).per(20)
    end

    respond_to do |format|
      format.html
      # format.js { render :layout => false }
    end
  end

  def create
    @parent = params[:post][:parent_type].constantize.find(params[:post][:parent_id])
    
    # if @parent.managers.include?(current_user)
    @post = Post.new(new_post_params)
    @post.parent = @parent
    @post.creator = current_user
    @post.save
    # end  

    if @post.save
      current_user.follow!(@post)
      current_user.record_create(@post)

      Analytics.km_created_post(current_user, @post)

      redirect_to vanity_post_path(@parent, @post)
    else
      flash[:alert] = 'Error posting'
      redirect_to vanity_path(@parent)
    end

  end

  def show
    @parent = Vanity.find(params[:vanity_id]).owner
    @post = @parent.posts.find(params[:id])
    @title = @post.headline
    @special_image = avatar_permalink(@parent)
    @description = @post.description

    @km_custom = Analytics.km_on_post(current_user, @post) if user_signed_in?    
      
    respond_to :html
  end

  def edit
    @post = Post.find(params[:id])  
    @title = "Edit post - " + @post.headline
    respond_to :html    
  end

  def update
    @post.update_attributes(post_params)
    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post has been successfully updated'
        format.html {redirect_to vanity_post_path(@post.parent, @post)}
      else
        format.html {redirect_to edit_vanity_post_path(@post.parent, @post)}
      end  
    end
  end

  def destroy
    @post.destroy
    if @post.destroy      
      flash[:notice] = "Post has been successfully deleted"
      redirect_to vanity_path(@parent)
    else
      flash[:alert] = 'Error deleting cube'
      redirect_to vanity_post_path(@post)
    end
  end

  private

  def parent_object
    v = Vanity.find(params[:vanity_id])
    return v.owner
  end  

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
    @post = Post.find(params[:id])
    @parent = @post.parent
    unless (@post.creator == current_user) || (@parent.managers.include?(current_user))
      raise ActionController::RoutingError.new('Not Found')
    end  
  end

end