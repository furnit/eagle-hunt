class Admin::Furniture::Wood::Type < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
end
