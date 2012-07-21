class UsersController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]
  # before_filter :correct_user, :except => [:show]

  def show
    redirect_to profile_path(params[:id])  
  end

  def edit
    @user = current_user
    respond_to do |format|
      format.html {redirect_to @user.permalink}
    end
  end

  def update
    @user = current_user

    respond_to do |format|
      if @user.save
        format.html {redirect_to :action => :edit}
      else
        format.html {redirect_to @user.permalink}
      end  
    end
  end

  def destroy
    # LEAVE THIS EMPTY
  end

  private

  def user_params
    params[:user].slice(:first_name, :last_name, :bio)
  end

  def user
    User.find_through_vanity(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user == @user
      raise ActionController::RoutingError.new('Not Found')
    end    
  end

end
