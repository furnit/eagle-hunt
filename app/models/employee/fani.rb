class Employee::Fani < ApplicationRecord
  belongs_to :users
  belongs_to :furnitures

  attr_accessor :days_to_complete_scale  
  
  has_many :furniture_build_details, through: :employee_fani_details, dependent: :destroy
    
  validates_presence_of :wage_rokob, :wage_khayat, :days_to_complete
  
  validates_numericality_of :days_to_complete, greater_than: 0

end
