class RegistrationsController < Devise::RegistrationsController

  def create
    if session[:omniauth] == nil #OmniAuth
       # if verify_recaptcha(:model => @user)
       #   super
       #   session[:omniauth] = nil unless @user.new_record? #OmniAuth
       # else
       #   build_resource
       #   clean_up_passwords(resource)
       #   flash[:alert] = "There was an error with the recaptcha code below. Please re-enter the code and click submit."
       #   render_with_scope :new
       # end

      if !verify_recaptcha
        flash.delete :recaptcha_error
        build_resource
        resource.valid?
        resource.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")
        clean_up_passwords(resource)
        respond_with_navigational(resource) { render_with_scope :new }
        session[:omniauth] = nil unless @user.new_record? #OmniAuth
      else
        session[:user_return_to] = nil
        flash.delete :recaptcha_error
        super
      end

    else
      super
      session[:omniauth] = nil unless @user.new_record? #OmniAuth
    end
  end

  protected

  def after_sign_up_path_for(resource)
    welcome_path
  end  

end