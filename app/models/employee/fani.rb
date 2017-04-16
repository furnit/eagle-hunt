class Employee::Fani < ApplicationRecord
  belongs_to :users
  belongs_to :furnitures
  
  has_and_belongs_to_many :furniture_build_details, class_name: '::FurnitureBuildDetail', foreign_key: :employee_fani_id
      
  validates_presence_of :wage_rokob, :wage_khayat, :days_to_complete

  attr_accessor :days_to_complete_scale
  
  validates_numericality_of :days_to_complete, greater_than: 0
end
