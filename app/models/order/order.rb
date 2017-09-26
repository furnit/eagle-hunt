class Order::Order < ApplicationRecord
  belongs_to :user
  belongs_to :furniture, class_name: '::Admin::Furniture::Furniture', foreign_key: :admin_furniture_furniture
  belongs_to :fabric_model, class_name: '::Admin::Furniture::Fabric::Model', foreign_key: :admin_furniture_fabric_model
  belongs_to :paint_color, class_name: '::Admin::Furniture::Paint::Color', foreign_key: :admin_furniture_paint_color
  belongs_to :wood_type, class_name: '::Admin::Furniture::Wood::Type', foreign_key: :admin_furniture_wood_type
  belongs_to :default, class_name: '::Admin::UploadedFile', foreign_key: :default_id
end
