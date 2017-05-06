class FurnitureBuildDetail < ApplicationRecord
  belongs_to :admin_furniture_section, class_name: 'Admin::Furniture::Section'
  belongs_to :admin_furniture_spec, class_name: 'Admin::Furniture::Spec'
  
  attr_accessor :admin_furniture_foam_type_id
  
  validates_presence_of :value
end
