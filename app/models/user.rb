class User < ActiveRecord::Base

  extend FriendlyId

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable

  # attr_reader :page_name
  friendly_id :page_name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_one   :vanity, 
            :as => :owner, 
            :dependent => :destroy

  has_many  :authentications, 
            :dependent => :destroy   
  
  has_many  :followages,
            :foreign_key => 'follower_id',
            :dependent => :destroy

  has_many  :followeds,
            :through => :followages

  has_many  :followed_users,
            :through => :followages,
            :source => :followed,
            :source_type => 'User'

  has_many  :followed_cubes,
            :through => :followages,
            :source => :followed,
            :source_type => 'Cube'

  has_many  :followed_posts,
            :through => :followages,
            :source => :followed,
            :source_type => 'Post'

  has_many  :reverse_followages,
            :as => :followed,
            :class_name => 'Followage',
            :dependent => :destroy

  has_many  :followers,
            :through => :reverse_followages

  has_many  :roles,
            :as => :owner,
            :dependent => :destroy

  has_many  :manager_roles,
            :as => :owner,
            :class_name => 'Role',
            :conditions => {:tipe => 'manager'}            

  has_many  :managed_cubes,
            :through => :manager_roles,
            :source => :on,
            :source_type => 'Cube'            

  has_many  :participated_cubes,
            :through => :roles,
            :source => :on,
            :source_type => 'Cube'
            
  has_many  :created_cubes,
            :class_name => 'Cube', 
            :foreign_key => 'creator_id', 
            :dependent => :nullify

  has_many  :created_posts,
            :class_name => 'Post', 
            :foreign_key => 'creator_id', 
            :dependent => :destroy

  has_many  :created_replies,
            :class_name => 'Reply', 
            :foreign_key => 'creator_id', 
            :dependent => :destroy            
            
  # FIXME
  # has_many  :created_replies,
  #           :class_name => 'Reply', 
  #           :foreign_key => 'creator_id', 
  #           :dependent => :destroy

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
                  :bio,
                  :vanity,
                  :vanity_attributes,
                  :avatar

  validates :email,
            :presence => { :message => "Please enter your email address" },
            :uniqueness => { :message => "has already been taken" },
            :format => { :with => /\A[^@]+@[^@]+\z/ }
  validates :first_name, 
            :presence => { :message => "Please enter your first name" },
            :length => { :minimum => 1, :maximum => 16 },
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
  validates :page_name,
            :presence => { :message => "Please fill in your desired pagename" },
            :uniqueness => { :case_sensitive => false, :message => "has already been taken"},
            :length => { :minimum => 3, :maximum => 24, :message => "needs to be between 3 to 24 characters" },
            :exclusion => { :in => ALL_RESERVED_WORDS, :message => "has already been taken"},
            :format => { :with => /^[a-z\d]+([-_][a-z\d]+)*$/i, :message => 'Contains invalid characters'}           
            # :format => { :with => /\A[a-z0-9]+\z/i, :message => 'Contains invalid characters'} 
            
  # default_scope includes(:vanity)

  after_initialize :automake_vanity
  before_validation :save_page_name

  mount_uploader :avatar, AvatarUploader

  searchable do
    text :name, :stored => true
    text :page_name, :stored => true
    text :bio
  end    
  
  # handle_asynchronously :solr_index           
                  
  def permalink
    Rails.application.routes.url_helpers.vanity_path(self.page_name)
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

  def self.find_through_vanity(id)
    owner = Vanity.find(id).owner rescue nil
    owner && owner.class == User ? owner : nil 
  end

  def is_admin?
    return true if ((self.admin == true) || (self.super_admin == true))
  end

  def is_super_admin?
    return true if self.super_admin == true
  end

  ## Personalized items

  def cubes_to_check
    self.followed_cubes
  end

  ## User actions

  # Followages

  def following?(followed)
    self.followages.find_by_followed_id_and_followed_type(followed.id, followed.class.to_s)
  end

  def follow!(followed, options={})
    if !self.following?(followed) && self != followed
      f = Followage.new
      f.follower_id = self.id
      f.followed_id = followed.id
      f.followed_type = followed.class.to_s
      f.save!
    end
  end

  def unfollow!(followed)
    if self.following?(followed)    
      ActiveRecord::Base.transaction do
        # destroy followage and update tallies on both sides
        self.following?(followed).destroy  
      end
    end
  end  

  ## Facebook related

  # Standard Facebook stuffs

  def facebook_auth
    self.authentications.where{:provider == 'facebook'}.first rescue nil
  end

  # More advanced facebook stuffs

  def import_facebook_picture
    auth = self.facebook_auth
    if auth
      self.remote_avatar_url = auth.profile_picture_url(:size => 'large')
      self.save
    end
  end

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

  def save_page_name
    (self.page_name = self.vanity.name) unless self.page_name == self.vanity.name
  end

  private

  def automake_vanity
    if self.persisted? == false
      self.build_vanity unless self.vanity
    end
  end

end