class Admin::Furniture::Foam::Type < ApplicationRecord
  self.table_name = "admin_furniture_foam_types"

  validates_presence_of :name
  validates_uniqueness_of :name
end
