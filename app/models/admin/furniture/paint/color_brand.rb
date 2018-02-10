class Admin::Furniture::Paint::ColorBrand < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name

  has_one :price, class_name: '::Admin::Pricing::PaintColor', foreign_key: :admin_furniture_paint_color_brand_id
end
