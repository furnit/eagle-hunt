class Admin::FurnitureSection < ApplicationRecord

  validates_presence_of :name, :comment
  
  mount_uploaders :images,        ImageUploader
  
end
