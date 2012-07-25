class Participation < ActiveRecord::Base

  participation_types = ['manager']

  attr_accessible :nil

  belongs_to :participant, :polymorphic => true
  belongs_to :on, :polymorphic => true

  validates :tipe,
            :inclusion => { :in => participation_types, :message => "has already been taken"},
            :format => { :with => /\A[a-z0-9]+\z/i, :message => 'Contains invalid characters'}

end