class Picture < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :owner, :polymorphic => true
  mount_uploader :image, ImageUploader

end
