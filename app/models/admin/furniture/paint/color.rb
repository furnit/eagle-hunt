class Admin::Furniture::Paint::Color < ApplicationRecord
  belongs_to :quality, class_name: '::Admin::Furniture::Paint::ColorQuality', foreign_key: :admin_furniture_paint_color_qualities_id
  belongs_to :brand, class_name: '::Admin::Furniture::Paint::ColorBrand', foreign_key: :admin_furniture_paint_color_brands_id
  
  validates_presence_of :name, :color_value, :brand, :quality
  validates_uniqueness_of :name, scope: [:admin_furniture_paint_color_qualities_id, :admin_furniture_paint_color_brands_id]
  
  before_validation { color_value = "#" + color_value.gsub("#", "") if color_value}
  validates_format_of :color_value, with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i, message: :invalid
end
