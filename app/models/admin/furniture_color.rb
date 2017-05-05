class Admin::FurnitureColor < ApplicationRecord
  belongs_to :quality, class_name: '::Admin::FurnitureColorQuality', foreign_key: :admin_furniture_color_qualities_id
  belongs_to :brand, class_name: '::Admin::FurnitureColorBrand', foreign_key: :admin_furniture_color_brands_id
  
  validates_uniqueness_of :name, scope: [:admin_furniture_color_qualities_id, :admin_furniture_color_brands_id]
  
  validates_format_of :color_value, with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i, message: :invalid 
  
end
