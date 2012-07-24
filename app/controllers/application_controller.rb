class ApplicationController < ActionController::Base
  protect_from_forgery

  # protected

  def authenticate_admin!
    if !user_signed_in?
      redirect_to new_user_session_path
    elsif !current_user.is_admin? 
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def current_admin
    if user_signed_in?
      if current_user.is_admin?
        return current_user
      else
        nil
      end
    end  
  end

end
