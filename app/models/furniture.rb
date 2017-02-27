class Furniture < ApplicationRecord  
  mount_uploaders :images, FurnitureUploader
end
