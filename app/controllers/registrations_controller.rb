class RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
    @user.build_vanity
    respond_to do |format|
      format.html
    end    
  end

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

        @user = User.new(user_params)
        @user.build_vanity
        @user.vanity = Vanity.new_from_name(params[:user][:vanity][:name])
        @user.valid?
        @user.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")

        clean_up_passwords(@user)
        respond_with_navigational(@user) { render :new }
        session[:omniauth] = nil unless @user.new_record? #OmniAuth
      else
        @user = User.new(user_params)
        @user.build_vanity
        @user.vanity = Vanity.new_from_name(params[:user][:vanity][:name])
        @user.valid?
        @user.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")

        session[:user_return_to] = nil
        flash.delete :recaptcha_error
        @user.save
        sign_in(@user)
        redirect_to after_sign_in_path_for(@user)
      end

    else
      super
      session[:omniauth] = nil unless @user.new_record? #OmniAuth
    end
  end

  protected

  # def after_sign_up_path_for(resource)
  #   welcome_path
  # end  

  def user_params
    params[:user].slice(:email, :password, :password_confirmation, :first_name, :last_name)
  end  


end