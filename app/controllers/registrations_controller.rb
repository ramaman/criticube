class RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
    @user.build_vanity

    respond_to do |format|
      format.html
    end
  end

  def new_from_facebook
    if session["devise.omniauth_attributes"]
      @user = User.new_with_facebook_session(session["devise.omniauth_attributes"])
      respond_to do |format|
        format.html
      end
    else
      redirect_to user_omniauth_authorize_path(:facebook)
    end
  end

  def create
    if !session["devise.omniauth_attributes"] #OmniAuth

      @user = User.new(user_params)
      @user.build_vanity
      @user.vanity = Vanity.new_from_name(params[:user][:vanity_attributes][:name])
      @user.valid?

      if !verify_recaptcha#(:model => @user) # Recaptcha validation fails
        
        flash.delete :recaptcha_error
        @user.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")
        clean_up_passwords(@user)
        respond_with_navigational(@user) { render_with_scope :new }
        session[:omniauth] = nil unless @user.new_record? #OmniAuth

      else

        # @user.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")
        session[:user_return_to] = nil
        flash.delete :recaptcha_error
        @user.save
        sign_in(@user)
        redirect_to after_sign_in_path_for(@user)

      end

    else

      raise 'error'

      @user = User.new(user_params)
      @user.build_vanity
      @user.vanity = Vanity.new_from_name(params[:user][:vanity_attributes][:name])
      if @user.valid? == true
        @user.save_with_facebook_session(session["devise.omniauth_attributes"])
        sign_in_and_redirect @user, after_sign_in_path_for(@user)

      else
        respond_with_navigational(@user) { render_with_scope :new_from_facebook }
      end
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