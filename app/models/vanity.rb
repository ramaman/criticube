class Vanity < ActiveRecord::Base

  extend FriendlyId

  attr_accessible nil

  belongs_to :owner, :polymorphic => true   

  friendly_id :name

  validates :name,
            :presence => { :message => "Please fill in your desired pagename" },
            :uniqueness => { :case_sensitive => false, :message => "has already been taken"},
            :length => { :minimum => 3, :maximum => 24 },
            :exclusion => { :in => ALL_RESERVED_WORDS, :message => "has already been taken"},
            :format => { :with => /\A[a-z0-9]+\z/i, :message => 'Contains invalid characters'}  

  def self.new_from_name(name)
    v = Vanity.new
    v.name = name
    return v
  end

end
