class Cube < ActiveRecord::Base
  
  # attr_accessible :title, :body
  attr_accessible :name
                  :description
                  :language

  validates :name,
            :presence => { :message => "Please fill in your desired pagename" },
            :uniqueness => { :case_sensitive => false, :message => "has already been taken"},
            :length => { :minimum => 3, :maximum => 24, :message => "needs to be between 3 to 24 characters" },
  validates :description,
            :length => {:maximum => 500 , :allow_nil => true, :allow_blank => true}          
  validates :language,          
            :inclusion => { :in => LANGUAGES, :message => "is not supported"},
            :format => { :with => /\A[a-z0-9]+\z/i, :message => 'Contains invalid characters'}                   


end
