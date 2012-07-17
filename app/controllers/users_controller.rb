class UsersController < ApplicationController

  def show
    redirect_to profile_path(params[:id])  
  end

  def update

    # DO NOT MASS ASSIGN!!!
  end


  private

  def user_params
    params[:user].slice(:first_name, :last_name)
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
