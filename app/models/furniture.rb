class Furniture < ApplicationRecord
  belongs_to :furnitaure_detail
  belongs_to :furnitaure_wage
  
  mount_uploaders :images, FurnitureUploader
end
