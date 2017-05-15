class Admin::Selling::Config::Price < ApplicationRecord
  { furniture: :furniture, fabric_brand: :fabric, paint_color_brand: :paint_color, wood_type: :wood }.each do |c, label|
    belongs_to label, class_name: :"::Admin::Furniture::#{c.to_s.classify}", foreign_key: :"admin_furniture_#{c.to_s}_id"
  end
  validates_uniqueness_of :admin_furniture_furniture_id
end
