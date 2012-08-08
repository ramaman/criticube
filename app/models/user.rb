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
            
  has_many  :activities,
            :class_name => 'Activity', 
            :foreign_key => 'actor_id', 
            :dependent => :destroy

  has_many  :primary_activity_objekts,
            :class_name => 'Activity',
            :as => :primary_objekt,
            :dependent => :destroy 

  has_many  :notifications,
            :dependent => :destroy

  has_many  :messages,
            :class_name => 'Message',
            :foreign_key => 'recipient_id', 
            :dependent => :destroy

  has_many  :unread_messages,
            :class_name => 'Message',
            :foreign_key => 'recipient_id',
            :conditions => {:read => false},             
            :dependent => :destroy
            
  has_many  :sent_messages,
            :class_name => 'Message',
            :foreign_key => 'sender_id', 
            :dependent => :destroy                               

  has_many  :evaluations, class_name: "RSEvaluation", as: :source

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
                  :avatar,
                  :subscribe_messages

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
  after_create :follow_starter_cubes

  mount_uploader :avatar, AvatarUploader

  searchable do
    text :name, :stored => true
    text :page_name, :stored => true
    text :bio
  end             
                  
  def permalink
    Rails.application.routes.url_helpers.vanity_path(self.page_name)
  end

  def url
    self.permalink
  end

  def follow_permalink
    Rails.application.routes.url_helpers.vanity_follow_path(self)
  end

  def unfollow_permalink
    Rails.application.routes.url_helpers.vanity_unfollow_path(self)
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

  def story_name
    'User'
  end

  def description
    self.bio
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

  def is_following?(followed)
    self.following?(followed) ? true : false
  end

  def follow!(followed, options={})
    if !self.following?(followed) && self != followed
      f = Followage.new
      f.follower_id = self.id
      f.followed_id = followed.id
      f.followed_type = followed.class.to_s
      f.save!
      if options[:record] == true
        self.record_follow(followed)
      end  
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

  # Voting

  def voted?(voted)
    evaluations.where(target_type: voted.class.to_s, target_id: voted.id).first rescue nil
  end

  def voted_with_direction?(voted)
    e = evaluations.where(target_type: voted.class.to_s, target_id: voted.id).first rescue nil
    if e
      (e.value > 0) ? 'up' : 'down'
    end
  end

  def can_vote?(voted)
    evaluations.where(target_type: voted.class.to_s, target_id: voted.id).present? ? nil : true
  end

  def vote(voted, direction)
    if voted.creator != self
      if direction == 'up'
        voted.add_or_update_evaluation(:votes, 1, self)
      elsif direction == 'down'
        voted.add_or_update_evaluation(:votes, -1, self)
      end
    end
  end

  def unvote(voted)
    voted.delete_evaluation(:votes, self)
  end

  ## Messages

  def fetch_conversations
    Message.joins(:recipient, :sender).where{
      |m| (m.recipient_id == self.id) & (m.sender_id != self.id)
      }.select("DISTINCT ON (messages.sender_id) *").
      order('messages.sender_id, messages.created_at DESC').
      limit(1000).
      sort {|a,b| b.created_at <=> a.created_at}
  end

  def fetch_conversation_partners
    User.find_by_sql(%Q{
      select * from users where id in (
          select recipient_id as user_id from messages where sender_id = #{self.id}
          union all
          select sender_id as user_id from messages where recipient_id = #{self.id}
      )
    })
  end

  def fetch_conversation_with(user)
    Message.joins(:recipient, :sender).where{ |m|
      ((m.sender_id == self.id) & (m.recipient_id == user.id)) |
      ((m.sender_id == user.id) & (m.recipient_id == self.id))
    }.order('messages.created_at DESC')
  end

  def mark_read_conversation_with(user)
    unread_messages = Message.where{ |m|
      (((m.sender_id == self.id) & (m.recipient_id == user.id)) |
      ((m.sender_id == user.id) & (m.recipient_id == self.id))) &
      m.read == false
    }
    unread_messages.each do |message|
      message.read = true
      message.save 
    end
    self.unread_messages_count = self.unread_messages.count
    self.save
  end

  def send_message_to!(user, body)
    if user != self
      m = Message.new(:body => body)
      m.sender = self
      m.recipient = user
      m.save!
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

  def follow_starter_cubes
    one = Cube.find('criticube_beginners') rescue nil
    self.follow!(one) if one
  end

  # Feed

  def dashboard_feed
    followages = self.followages
    user_ids = followages.where{followed_type == 'User'}.collect{|f| f.followed_id}
    cube_ids = followages.where{followed_type == 'Cube'}.collect{|f| f.followed_id}
    post_ids = followages.where{followed_type == 'Post'}.collect{|f| f.followed_id}
    Activity.where{ |a|
      (a.actor_id >> user_ids) |
      ((a.secondary_objekt_id >> cube_ids) & (a.secondary_objekt_type == 'Cube')) |
      ((a.secondary_objekt_id >> post_ids) & (a.secondary_objekt_type == 'Post'))
    }.includes(
      :actor,
      :primary_objekt,
      :secondary_objekt,
      :tertiary_objekt            
    ).order('created_at DESC')
  end

  def feed
    Activity.clean.where{ |a|
      (a.actor_id == self.id) |
      ((a.primary_objekt_type == 'User') & (a.primary_objekt_id == self.id))
    }.order('created_at DESC')
  end

  # Feed recording

  def record_follow(primary_objekt)
    existing_activity = Activity.where{ |a|
      (a.actor_id == self.id) & (a.action == 'followed') & 
      (a.primary_objekt_id == primary_objekt.id) & 
      (a.primary_objekt_type == primary_objekt.class.to_s)
    }
    if existing_activity.length > 0
      existing_activity.each {|a| a.set_as_archived}
    end
    Activity.create(
      :actor => self,
      :action => 'followed',
      :primary_objekt => primary_objekt
    )
  end

  # handle_asynchronously :record_follow

  def record_create(primary_objekt)
    if primary_objekt.class == Cube
      Activity.create(
        :actor => self,
        :action => 'created',
        :primary_objekt => primary_objekt
      )
    elsif primary_objekt.class == Post
      Activity.create(
        :actor => self,
        :action => 'created',
        :primary_objekt => primary_objekt,
        :secondary_objekt => primary_objekt.parent
      )
    elsif primary_objekt.class == Reply  
      Activity.create(
        :actor => self,
        :action => 'created',
        :primary_objekt => primary_objekt,
        :secondary_objekt => primary_objekt.container,
        :tertiary_objekt => primary_objekt.container.parent
      )
    end
  end
   
  # handle_asynchronously :record_create

  def automake_vanity
    if self.persisted? == false
      self.build_vanity unless self.vanity
    end
  end

  # handle_asynchronously :solr_index  


end