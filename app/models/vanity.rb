class Vanity < ActiveRecord::Base

  extend FriendlyId

  friendly_id :name

  attr_accessible nil

  belongs_to :owner, :polymorphic => true   

  validates :name,
            :presence => { :message => "Please fill in your desired pagename" },
            :uniqueness => { :case_sensitive => false, :message => "has already been taken"},
            :length => { :minimum => 3, :maximum => 24, :message => "needs to be between 3 to 24 characters" },
            :exclusion => { :in => ALL_RESERVED_WORDS, :message => "has already been taken"},
            :format => { :with => /\A[a-z0-9]+\z/i, :message => 'Contains invalid characters'}  

  before_validation :cleanup

  def self.new_from_name(name)
    v = Vanity.new
    v.name = name
    return v
  end

  private

  def cleanup
    self.name = self.name.downcase
  end

end
