class Admin::Furniture::Paint::ColorQuality < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
end
