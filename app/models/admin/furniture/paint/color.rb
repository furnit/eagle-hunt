class Admin::Furniture::Paint::Color < ApplicationRecord
  belongs_to :quality, class_name: '::Admin::Furniture::Paint::ColorQuality', foreign_key: :admin_furniture_paint_color_qualities_id
  belongs_to :brand, class_name: '::Admin::Furniture::Paint::ColorBrand', foreign_key: :admin_furniture_paint_color_brands_id
  
  validates_uniqueness_of :name, scope: [:admin_furniture_paint_color_qualities_id, :admin_furniture_paint_color_brands_id]
  
  before_validation { self.color_value = "#" + self.color_value.gsub("#", "") }
  validates_format_of :color_value, with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i, message: :invalid 
end
