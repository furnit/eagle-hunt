class Admin::Selling::Config::Price < ApplicationRecord
  belongs_to :set, class_name: "::Admin::Furniture::Set", foreign_key: :admin_furniture_set_id
  belongs_to :wood, class_name: "::Admin::Furniture::Wood::Type", foreign_key: :admin_furniture_wood_type_id
  belongs_to :furniture, class_name: "::Admin::Furniture::Furniture", foreign_key: :admin_furniture_furniture_id
  belongs_to :fabric_brand, class_name: "::Admin::Furniture::Fabric::Brand", foreign_key: :admin_furniture_fabric_brand_id
  belongs_to :paint_color, class_name: "::Admin::Furniture::Paint::ColorBrand", foreign_key: :admin_furniture_paint_color_brand_id
  
  # don't validate presence of the attributes, introduced from commit@13426a0
  #   the issue raised testing the site from at commit@1b64071 which the at the method 
  #   `Admin::Selling::Config::PricesController.set_admin_selling_config_price()` when trying to `.find_or_create()` this model
  #   validation will fail and the site won't perform! 
  # validates_presence_of :overall_cost, :set, :wood, :fabric_brand, :furniture, :paint_color
  validates_numericality_of :overall_cost, greater_than: 0, allow_nil: true
  validates_uniqueness_of :furniture
end
