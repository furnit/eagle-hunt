class Admin::FabricType < ApplicationRecord
  
  validates_presence_of :name, :comment
  
end
