class VanitiesController < ApplicationController

  def show
    if owner.class == User
      @user = owner
    end
    respond_to do |format|
      format.html
    end    
  end

  private

  def owner
    vanity = Vanity.find(params[:id]).owner rescue nil
    vanity ? vanity : (raise ActionController::RoutingError.new('Not Found'))
  end

end