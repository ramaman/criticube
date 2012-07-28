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

end