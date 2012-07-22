class UsersController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]
  before_filter :correct_user, :except => [:old_show, :show]

  def old_show
    redirect_to vanity_path(params[:id])  
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    respond_to do |format|
      if @user.save
        flash[:notice] = 'Your profile has been successfully updated'
        format.html {redirect_to vanity_path(@user)}
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
