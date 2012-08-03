class Post < ActiveRecord::Base

  tipes = ['opinion']

  extend FriendlyId

  friendly_id :headline, :use => :slugged

  belongs_to  :creator, 
              :class_name => 'User',
              :foreign_key => 'creator_id'
              
  belongs_to  :parent,
              :polymorphic => true

  belongs_to  :cube,
              :class_name => 'Cube',
              :foreign_key => 'owner_id'  

  has_many  :reverse_followages,
            :as => :followed,
            :class_name => 'Followage',
            :dependent => :destroy

  has_many  :followers,
            :through => :reverse_followages              
              
  has_many  :replies,
            :as => :container
            
  has_many  :primary_activity_objekt,
            :class_name => 'Activity',
            :as => :primary_objekt,
            :dependent => :destroy
            
  has_many  :secondary_activity_objekt,
            :class_name => 'Activity',
            :as => :secondary_objekt,
            :dependent => :destroy

  attr_accessible :headline,
                  :content,
                  :tipe

  validates :headline,
            :presence => true #,
            # :length => { :minimum => 7, :maximum => 200 }
  validates :content,
            :length => { :maximum => 3550, :allow_nil => true, :allow_blank => true }
  validates :slug,
            :uniqueness => true
  validates :tipe,
            :inclusion => { :in => tipes, :message => "is not supported"}
  validates :parent,
            :presence => true         

  default_scope includes{cube.managers creator}.order('created_at DESC')

  before_validation :cleanup

  def name
    self.headline
  end  

  def self.display_name
    'opinion'
  end

  def story_name
    'post'
  end

  def context_tipe
    'opinion' if self.tipe == 'opinion'
  end

  def tipe_name
    'an opinion' if self.tipe == 'opinion'
  end

  # def normalize_friendly_id(string)
  #   super[0..100] + '-post'
  # end

  def can_edit?(user)

  end

  def can_delete(user)

  end

  def should_generate_new_friendly_id?
    new_record?
  end  

  private

  def cleanup
    self[:headline] = self[:headline].strip
    if self[:content] 
      self[:content].gsub(/<code>.+?<\/code>/) {|s| s.gsub(/<br\s*\/?>/, "")}
      self[:content].gsub(/<p>[\s$]*<\/p>/, '')
      self[:content].gsub! /(&nbsp;|\s)+/, ' '
      self[:content] = Sanitize.clean( self[:content], 
          :elements => %w(a abbr b blockquote cite dd dfn dl dt em i kbd li mark ol p pre q s samp small strike strong sub sup time u ul var),
          :attributes => {'a' => ['href', 'title'], 'span' => ['class']},
          :protocols => {'a' => {'href' => ['http', 'https', 'mailto']}}
          )
    end
  end  

end