class Admin::FurnitureSpec < ApplicationRecord
  
  validates_presence_of :name, :comment
  
end
