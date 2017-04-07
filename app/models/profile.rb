class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :state

  validates_presence_of :first_name, :last_name, :address

  def full_name
    "%s %s" %[first_name, last_name]
  end

  def full_name= fn
    sp = fn.to_s.split(' ')
    self.first_name = sp.first
    self.last_name  = sp[1..-1].join ' '
  end
end
