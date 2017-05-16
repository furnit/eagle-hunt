class FurnitureBuildDetail < ApplicationRecord
  belongs_to :spec, class_name: 'Admin::Furniture::Spec', foreign_key: :admin_furniture_spec_id
  belongs_to :section, class_name: 'Admin::Furniture::Section', foreign_key: :admin_furniture_section_id
  
  attr_accessor :admin_furniture_foam_type_id
  
  validates_presence_of :value
end
