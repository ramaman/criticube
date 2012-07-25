class Role < ActiveRecord::Base

  tipe = ['manager']

  attr_accessible :nil

  belongs_to :owner, :polymorphic => true
  belongs_to :on, :polymorphic => true

  validates :tipe,
            :inclusion => { :in => tipe, :message => "not supported"},
            :format => { :with => /\A[a-z0-9]+\z/i, :message => 'Contains invalid characters'}

  def self.new_assignment(owner, on, tipe)
    r = Role.new
    r.tipe = tipe
    r.owner = owner
    r.on = on
    return r
  end

end