class Admin::Furniture::Paint::ColorBrand < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
end
