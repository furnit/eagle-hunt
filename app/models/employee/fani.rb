class Employee::Fani < ApplicationRecord
  attr_accessor :days_to_complete_scale
  
  has_many :furniture_build_details, through: :employee_fani_details, dependent: :destroy
  accepts_nested_attributes_for :furniture_build_details, :allow_destroy => true
end
