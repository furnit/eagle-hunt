class Admin::FurnitureColor < ApplicationRecord
  belongs_to :admin_furniture_color_qualities
  belongs_to :admin_furniture_color_brand
end
