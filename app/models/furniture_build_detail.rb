class FurnitureBuildDetail < ApplicationRecord
  belongs_to :admin_furniture_section, class_name: 'Admin::FurnitureSection'
  belongs_to :admin_furniture_spec, class_name: 'Admin::FurnitureSpec'
  
  attr_accessor :admin_furniture_foam_type_id
  
  validates_presence_of :value
end
