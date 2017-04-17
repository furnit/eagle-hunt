class NotifyOnFurnitureAvailable < ApplicationRecord
  belongs_to :admin_furniture
  validates_presence_of :phone_number
  validates_uniqueness_of :admin_furniture_id, scope: :phone_number
end
