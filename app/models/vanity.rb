class Vanity < ActiveRecord::Base
  attr_accessible nil

  belongs_to :owner, :polymorphic => true

  validates :name,
            :presence => { :message => "Please fill in your desired pagename" },
            :uniqueness => { :case_sensitive => false, :message => "Name has already been taken"},
            :length => { :minimum => 3, :maximum => 24 },
            :exclusion => { :in => ALL_RESERVED_WORDS, :message => "Name has already been taken"},
            :format => { :with => /\A[a-z0-9]+\z/i, :message => 'Contains invalid characters'}  

end
