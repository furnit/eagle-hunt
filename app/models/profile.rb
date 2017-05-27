class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :state

  before_validation { self.postal_code = self.postal_code.gsub(/[- ]+/, "") if self.postal_code }

  validates_presence_of :first_name, :last_name, :address, :state, :user
  validates_length_of :postal_code, is: 10, allow_blank: true
  validates_numericality_of :postal_code, greater_than: 0, allow_blank: true
  validate :make_sure_persian


  def make_sure_persian
    [:first_name, :last_name, :address].each do |f|
      if not(eval("self.#{f}") and eval("self.#{f}").is_arabic?)
        errors.add f, :not_persian
      end
    end
  end

  def full_name
    "%s %s" %[first_name, last_name]
  end

  def full_name= fn
    sp = fn.to_s.split(' ')
    self.first_name = sp.first
    self.last_name  = sp[1..-1].join ' '
  end
end
