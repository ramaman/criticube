class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, 
                  :password, 
                  :password_confirmation, 
                  :remember_me,
                  :first_name,
                  :middle_names,
                  :last_name

  validates :email,
            :presence => { :message => "Please enter your email address" }
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
  validates :date_of_birth, 
            :presence => { :message => "Please enter your date of birth" }#,
#           :inclusion => { :in => (Time.now.years_ago(150)..Time.now.years_ago(18)), :message => "Sorry, you need to be 18 years or older"}
  validates :gender,
            :inclusion => { :in => %w(Undisclosed Female Male)}
  validates :bio,
            :length => {:maximum => 200, :allow_nil => true, :allow_blank => true }

  has_one :vanity, :dependent => :destroy

end
