class Admin::Furniture::Spec < ApplicationRecord
  
  validates_presence_of :name, :comment, :unit
  
end
