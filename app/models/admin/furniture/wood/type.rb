class Admin::Furniture::Wood::Type < ApplicationRecord
  self.table_name = "admin_furniture_wood_types"

  validates_presence_of :name
  validates_uniqueness_of :name
  has_one :price, class_name: '::Admin::Pricing::Wood', foreign_key: :admin_furniture_wood_type_id
end
