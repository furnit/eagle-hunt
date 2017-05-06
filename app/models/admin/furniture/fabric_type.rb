class Admin::Furniture::FabricType < ApplicationRecord
  
  validates_presence_of :name, :comment
  
end
