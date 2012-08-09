class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :banned?, :store_location

  def store_location
    session[:user_return_to] = request.url unless 
    (params[:controller] == "devise/sessions") || 
    (params[:controller] == "devise/registrations") ||
    (params[:controller] == "search") ||
    (params[:controller] == 'authentications') ||
    (params[:controller] == 'omniauth_callbacks') ||
    (params[:controller] == 'registrations') ||
    ((params[:controller] == 'facebook') && (params[:action] == 'relogin'))
  end

  def after_sign_in_path_for(resource)
    return request['omniauth.origin'] || stored_location_for(resource)
    # root_path(:protocol => 'http')
  end

  protected

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

  def banned?
    if current_user.present? && current_user.banned?
      sign_out current_user
      flash[:notice] = "This account has been suspended"
      root_path
    end
  end

  def miniprofiler
    Rack::MiniProfiler.authorize_request if (user_signed_in? && current_user.is_admin?)
  end  
end
