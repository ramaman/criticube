class Notification < ActiveRecord::Base

  belongs_to :activity
  belongs_to :user

  # attr_accessible :title, :body
end
