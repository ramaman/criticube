class FollowagesController < ApplicationController

  before_filter :authenticate_user!, :except => [:following, :followers]

  def create
    if params[:followage]
      @parent = Object.const_get(params[:followage][:followed_type]).find(params[:followage][:followed_id])
      current_user.follow!(@parent, :record => true)
    end
    
    respond_to do |format|
      format.html { redirect_to @parent }
      format.js { render :layout => false }
    end    
  end

  def destroy
    @followage = Followage.find(params[:id])
    @parent = @followage.followed
    current_user.unfollow!(@parent)

    respond_to do |format|
      format.html { redirect_to @parent }
      format.js { render :layout => false }
    end
  end

  def following
    @tipe = params[:tipe].singularize
    @parent = User.find(params[:id])
    if (@parent.class == User) && (['user','cube', 'post'].include?(@tipe)) 
      @followeds = @parent.send("followed_#{params[:tipe]}").page(params[:page]).per(25)
      respond_to do |format|
        format.html 
        # format.js { render :layout => false }
      end
    else
      raise ActionController::RoutingError.new('Not Found')  
    end
  end

  def followers
    @parent = parent_object
    @followers = @parent.followers.page(params[:page]).per(25)
    respond_to do |format|
      format.html
      # format.js { render :layout => false }
    end
  end

  private

  def parent_object
    v = Vanity.find(params[:id])
    return v.owner
  end  

  def parent_url(parent)
    case
      when params[:cube_id] then vanity_path(parent)
    end
  end

  # Delete this if shit
  # def parent_following_url(parent)
  #   case
  #     when params[:user_id] then User.find(params[:user_id])
  #     when params[:fact_id] then Fact.find(params[:fact_id])
  #     when params[:topic_id] then Topic.find(params[:topic_id])
  #     when params[:link_id] then Link.find(params[:link_id])
  #   end
  # end

end