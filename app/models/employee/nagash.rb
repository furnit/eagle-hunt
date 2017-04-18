class Employee::Nagash < ApplicationRecord
  belongs_to :users
  belongs_to :furnitures
  
  attr_accessor :days_to_complete_scale
  
  validates_numericality_of :days_to_complete, greater_than: 0
  validates_presence_of :wage, :astare_avaliye, :astare_asli, :range_asli, :rouye, :days_to_complete
end
