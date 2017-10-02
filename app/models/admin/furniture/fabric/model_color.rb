class Admin::Furniture::Fabric::ModelColor < ApplicationRecord
  belongs_to :model, foreign_key: :admin_furniture_fabric_model_id, class_name: '::Admin::Furniture::Fabric::Model'
  belongs_to :color, foreign_key: :admin_furniture_fabric_color_id, class_name: '::Admin::Furniture::Fabric::Color'

  validates_presence_of :models, :color
  validates_uniqueness_of :models, scope: :color
end
