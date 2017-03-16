class Picture < ApplicationRecord
  
  
  mount_uploaders :images, ImageUploader
  
end
