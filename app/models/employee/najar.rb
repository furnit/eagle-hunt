class Employee::Najar < ApplicationRecord
  belongs_to :users
  belongs_to :furnitures
  
  attr_accessor :days_to_complete_scale
  
  validates_numericality_of :days_to_complete, greater_than: 0
  validates_presence_of :wage, :choob, :days_to_complete
end
