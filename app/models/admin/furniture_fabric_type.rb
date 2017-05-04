class Admin::FurnitureFabricType < ApplicationRecord
  
  validates_presence_of :name, :comment
  
end
