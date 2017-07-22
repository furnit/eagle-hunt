class Admin::Furniture::Wood::Type < ApplicationRecord
  self.table_name = "admin_furniture_wood_types"

  validates_presence_of :name
  validates_uniqueness_of :name
end
