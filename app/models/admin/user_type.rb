class Admin::UserType < ApplicationRecord
  
  validates_presence_of :name, :symbol, :auth_level
  
  validates :name, :symbol, uniqueness: true
  
end
