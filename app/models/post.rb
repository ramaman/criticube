class Post < ActiveRecord::Base

  tipes = ['opinion']

  extend FriendlyId
  include PgSearch  

  friendly_id :headline, :use => :slugged

  belongs_to  :creator, 
              :class_name => 'User',
              :foreign_key => 'creator_id'
              
  belongs_to  :parent,
              :polymorphic => true

  belongs_to  :cube,
              :class_name => 'Cube',
              :foreign_key => 'owner_id'  
              
  has_many  :replies,
            :as => :container                          

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

  default_scope includes{cube.managers creator}

  before_validation :cleanup

  pg_search_scope :pg_search, 
                  :against => [:headline]  

  def name
    self.headline
  end  

  def normalize_friendly_id(string)
    super[0..100]
  end

  def can_edit?(user)

  end

  def can_delete(user)

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