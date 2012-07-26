class FollowagesController < ApplicationController

  before_filter :authenticate_user!

  def create
    if params[:followage]
      @parent = Object.const_get(params[:followage][:followed_type]).find(params[:followage][:followed_id])
      current_user.follow!(@parent)
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
    @tipe = params[:tab].singularize
    if ['topic','user','fact','link'].include?(@tipe)   
      @parent = User.find(params[:user_id])    
      @followages = @parent.followages.where{|f| f.followed_type == @tipe.capitalize}.page(params[:page]).per(25)
      respond_to do |format|
        format.html 
        format.js { render :layout => false }
      end
    else
      raise ActionController::RoutingError.new('Not Found')  
    end
  end

  def followers
    @parent = parent_object
    @followers = @parent.followers.limit('1000').page(params[:page]).per(25)
    respond_to do |format|
      format.html
      format.js { render :layout => false }
    end
  end

  private

  def parent_object
    case
      when params[:user_id] then User.find(params[:user_id])
      when params[:cube_id] then Cube.find(params[:cube_id])        
    end
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