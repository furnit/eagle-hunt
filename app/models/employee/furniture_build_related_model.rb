class Employee::FurnitureBuildRelatedModel < ApplicationRecord
  self.abstract_class = true
  
  belongs_to :user
  belongs_to :furniture, class_name: '::Admin::Furniture::Furniture', foreign_key: :furniture_id
  
  attr_accessor :days_to_complete_scale
  
  validates_numericality_of :days_to_complete, greater_than: 0
end