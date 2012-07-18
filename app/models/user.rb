class User < ActiveRecord::Base

  extend FriendlyId

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  attr_reader :page_name
  friendly_id :page_name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :vanity, :as => :owner, :dependent => :destroy         

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
                  :vanity

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
            :presence => true #,
            # :vanity_name_uniqueness => true

  default_scope includes(:vanity)

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

  def find_through_vanity(id)
    owner = Vanity.find(id).owner
    owner.class == User ? owner : nil
  end

end
