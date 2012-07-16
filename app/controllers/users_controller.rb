class UsersController < ApplicationController

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

end
