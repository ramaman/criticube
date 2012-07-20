class User < ActiveRecord::Base

  extend FriendlyId
  include PgSearch

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable

  attr_reader :page_name
  friendly_id :page_name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_one :vanity, :as => :owner, :dependent => :destroy
  has_many :authentications, :dependent => :destroy      

  accepts_nested_attributes_for :vanity, 
                                :allow_destroy => false, 
                                :reject_if => proc {|a| a['name'].blank?}

  attr_accessible :email, 
                  :password, 
                  :password_confirmation, 
                  :remember_me,
                  :first_name,
                  :middle_names,
                  :last_name,
                  :page_name,
                  :vanity,
                  :vanity_attributes

  validates :email,
            :presence => { :message => "Please enter your email address" },
            :uniqueness => { :message => "has already been taken" },
            :format => { :with => /\A[^@]+@[^@]+\z/ }
  validates :first_name, 
            :presence => { :message => "Please enter your first name" },
            :length => { :minimum => 2, :maximum => 16 },
            :format => { :with => /^[^0-9`!@#\$%\^&*+_=]+$/ , :message => 'Contains invalid characters'}
  validates :middle_names,
            :length => { :maximum => 40, :allow_nil => true, :allow_blank => true },
            :format => { :with => /^[^0-9`!@#\$%\^&*+_=]+$/ , :message => 'Contains invalid characters', :allow_nil => true, :allow_blank => true }
  validates :last_name,
            :presence => { :message => "Please enter your last name" },
            :length => { :minimum => 2, :maximum => 30 },
            :format => { :with => /^[^0-9`!@#\$%\^&*+_=]+$/, :message => 'Contains invalid characters' }
  validates :bio,
            :length => {:maximum => 200, :allow_nil => true, :allow_blank => true }
  validates :vanity,
            :presence => true#,
            # :vanity_name_uniqueness => true

  default_scope includes(:vanity)

  after_initialize :automake_vanity

  pg_search_scope :search, 
                  :against => [:first_name, :middle_names, :last_name]
                  
  def permalink
    Rails.application.routes.url_helpers.profile_path(self.page_name)
  end

  def name
    if self.middle_names
      "#{self.first_name} #{self.middle_names} #{self.last_name}"
    else
      "#{self.first_name} #{self.last_name}"  
    end
  end

  def fast_name
    "#{self.first_name} #{self.last_name}"  
  end    
  
  def page_name
    self.vanity.name
  end

  def self.find_through_vanity(id)
    owner = Vanity.find(id).owner rescue nil
    owner && owner.class == User ? owner : nil 
  end

  ## Omniauth related

  def self.from_facebook(auth_hash)
    existing_auth = Authentication.where(auth_hash.slice(:provider, :uid)).first rescue nil
    if existing_auth
      return existing_auth.user
    else
      new_user = User.new
      new_user.email = auth_hash['extra']['raw_info']['email']
      new_user.first_name = auth_hash['info']['first_name']
      new_user.last_name = auth_hash['info']['last_name']
      return new_user
    end    
  end

  def self.new_with_facebook_session(session)
    user = User.new
    user.email = session['email']
    user.first_name = session['first_name']
    user.last_name = session['last_name']
    return user
  end

  def save_with_facebook_session(session)
    auth = Authentication.new
    auth.provider = 'facebook'
    auth.uid = session['uid']
    auth.token = session['token']
    auth.token_expires_at = session['token_expires_at']
    ActiveRecord::Base.transaction do    
      self.save!
      auth.user = self
      auth.save!
    end
  end

  def facebook_auth
    self.authentications.where{:provider == 'facebook'}.first rescue nil
  end

  def create_facebook_auth(omniauth_hash)
    if self.facebook_auth
      return self.facebook_auth
    else
      auth = Authentication.new
      auth.provider = 'facebook'
      auth.uid = omniauth_hash['uid']
      auth.token = omniauth_hash['credentials']['token']
      auth.token_expires_at = omniauth_hash['credentials']['token_expires_at']
      auth.user = self
      auth.save!
      return auth
    end
  end

  private

  def automake_vanity
    self.build_vanity unless self.vanity
  end

end
