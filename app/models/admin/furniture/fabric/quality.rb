class Admin::Furniture::Fabric::Quality < ApplicationRecord
  validates_presence_of :name, :comment
  validates_uniqueness_of :name
end
