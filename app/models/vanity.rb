class Vanity < ActiveRecord::Base

  extend FriendlyId

  friendly_id :name

  attr_accessible :name

  belongs_to :owner, :polymorphic => true   

  validates :name,
            :presence => { :message => "Please fill in your desired pagename" },
            :uniqueness => { :case_sensitive => false, :message => "has already been taken"},
            :length => { :minimum => 3, :maximum => 24, :message => "needs to be between 3 to 24 characters" },
            :exclusion => { :case_sensitive => false, :in => ALL_RESERVED_WORDS, :message => "has already been taken"},
            :format => { :with => /^[a-z\d]+([-_][a-z\d]+)*$/i, :message => 'Contains invalid characters'}
            # :format => { :with => /\A[a-z0-9]+\z/i, :message => 'Contains invalid characters'}  

  before_validation :cleanup, :downcase_name

  def self.new_from_name(name)
    v = Vanity.new
    v.name = name
    return v
  end

  private

  def downcase_name
    self.name = self.name.downcase
  end

  def cleanup
    self.name = self.name.downcase
  end

end
