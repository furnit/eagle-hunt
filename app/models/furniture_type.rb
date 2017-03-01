class FurnitureType < ApplicationRecord
  has_many :furniture
  mount_uploaders :images, FurnitureUploader
end
