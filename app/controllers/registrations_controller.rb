class RegistrationsController < Devise::RegistrationsController

  include Devise::Controllers::Rememberable

  def new
    @user = User.new
    @user.build_vanity
    @km_event = 'On Signup Form'

    respond_to do |format|
      format.html
    end
  end

  def new_from_facebook
    if session["devise.omniauth_attributes"]
      @user = User.new_with_facebook_session(session["devise.omniauth_attributes"])
      @km_event = 'On Signup Form'
      respond_to do |format|
        format.html
      end
    else
      redirect_to user_omniauth_authorize_path(:facebook)
    end
  end

  def create

    @user = User.new(user_params)
    @user.build_vanity
    @user.vanity = Vanity.new_from_name(params[:user][:vanity_attributes][:name])
    @user.valid?

    if !verify_recaptcha#(:model => @user) # Recaptcha validation fails
      flash.delete :recaptcha_error
      @user.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")
      clean_up_passwords(@user)
      render :new
      # session[:omniauth] = nil unless @user.new_record? #OmniAuth
    else
      # @user.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")
      session[:user_return_to] = nil
      flash.delete :recaptcha_error
      @user.save
      remember_me @user
      sign_in @user
      session[:signup] = true
      redirect_to after_sign_up_path_for(@user)
    end
  end

  def create_with_omniauth

    if session["devise.omniauth_attributes"]
      @user = User.new(user_params)
      @user.build_vanity
      @user.vanity = Vanity.new_from_name(params[:user][:vanity_attributes][:name])
      @user.valid?

      if @user.valid? == true
        @user.save_with_facebook_session(session["devise.omniauth_attributes"])
        if @user.persisted?
          @user.delay.import_facebook_picture
          remember_me @user
          sign_in @user
          session[:signup] = true
          redirect_to after_sign_up_path_for(@user)
        else
          render :new_from_facebook
        end        
      else
        render :new_from_facebook
      end

    else
      redirect_to user_omniauth_authorize_path(:facebook)
    end    
  end

  protected

  def after_sign_up_path_for(resource)
    cubes_path
  end  

  def user_params
    params[:user].slice(:email, :password, :password_confirmation, :first_name, :last_name)
  end  


end