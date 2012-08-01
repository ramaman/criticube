class Cube < ActiveRecord::Base
  
  extend FriendlyId
  include PgSearch

  friendly_id :page_name

  belongs_to  :creator, 
              :class_name => 'User',
              :foreign_key => 'creator_id'

  has_one   :vanity,
            :as => :owner,
            :dependent => :destroy

  has_many  :roles,
            :as => :on,
            :dependent => :destroy

  has_many  :members,
            :through => :roles,
            :source => :owner,
            :source_type => 'User'
            
  has_many  :manager_roles,
            :as => :on,
            :class_name => 'Role',
            :conditions => {:tipe => 'manager'}

  has_many  :managers,
            :through => :manager_roles,
            :source => :owner,
            :source_type => 'User'
                        
  has_many  :reverse_followages,
            :as => :followed,
            :class_name => 'Followage',
            :dependent => :destroy

  has_many  :followers,
            :through => :reverse_followages
            
  has_many  :posts,
            :as => :parent 

  has_many  :opinions,
            :as => :parent,
            :class_name => 'Post',
            :conditions => {:tipe => 'opinion'}
            
  has_many  :primary_activity_objekt,
            :class_name => 'Activity',
            :as => :primary_objekt,
            :dependent => :destroy
            
  has_many  :secondary_activity_objekt,
            :class_name => 'Activity',
            :as => :secondary_objekt,
            :dependent => :destroy
            
  has_many  :tertiary_activity_objekt,
            :class_name => 'Activity',
            :as => :tertiary_objekt,
            :dependent => :destroy                                                                                  

  accepts_nested_attributes_for :vanity,
                                :allow_destroy => false, 
                                :reject_if => proc {|a| a['name'].blank?}

  attr_accessible :name,
                  :description,
                  :language,
                  :vanity,
                  :vanity_attributes,
                  :avatar                  

  validates :name,
            :presence => :true,
            :length => { :minimum => 3, :maximum => 100, :message => "needs to be between 3 to 24 characters" },
            :format => { :with => /^[^0-9`!@#\$%\^&*+_=]+$/, :message => 'Contains invalid characters' }
  validates :description,
            :length => {:maximum => 500 , :allow_nil => true, :allow_blank => true}          
  validates :language,          
            :inclusion => { :in => LANGUAGES, :message => "is not supported"},
            :format => { :with => /\A[a-z0-9]+\z/i, :message => 'Contains invalid characters'}                   
  validates :vanity,
            :presence => true
  # validates :tipe,
  #           :inclusion => { :in => tipe, :message => "invalid tipe"},
  #           :format => { :with => /\A[a-z0-9]+\z/i, :message => 'Contains invalid characters'}
  validates :page_name,
            :presence => { :message => "Please fill in your desired pagename" },
            :uniqueness => { :case_sensitive => false, :message => "has already been taken"},
            :length => { :minimum => 3, :maximum => 24, :message => "needs to be between 3 to 24 characters" },
            :exclusion => { :in => ALL_RESERVED_WORDS, :message => "has already been taken"},
            :format => { :with => /^[a-z\d]+([-_][a-z\d]+)*$/i, :message => 'Contains invalid characters'}
            # :format => { :with => /\A[a-z0-9]+\z/i, :message => 'Contains invalid characters'}             

  # default_scope includes(:vanity)

  mount_uploader :avatar, AvatarUploader  

  after_initialize :automake_vanity
  before_validation :save_page_name

  pg_search_scope :pg_search, :against => [:name, :page_name],
                  :using => {:tsearch => {:prefix => true}}
                  
  searchable do
    text :name, :stored => true 
    text :language, :stored => true
    text :page_name, :stored => true
    text :description
  end

  # handle_asynchronously :solr_index

  def tipe_name
    'a cube'
  end

  def assign_manager(owner)
    r = Role.where(:tipe => 'manager', :owner_id => owner.id, :owner_type => owner.class.to_s.downcase, :on_id => self.id, :on_type => self.class.to_s.downcase)
    if r.length > 0
      r.each {|o| o.destroy}
      self.roles << Role.new_assignment(owner, self, 'manager')
    else
      self.roles << Role.new_assignment(owner, self, 'manager')
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