class FurnitureBuildDetail < ApplicationRecord
  belongs_to :admin_furniture_sections
  belongs_to :admin_furniture_specs
  
  attr_accessor :admin_furniture_stuff_abr_id
  
  validates_presence_of :value
end
