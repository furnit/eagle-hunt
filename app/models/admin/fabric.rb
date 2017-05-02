class Admin::Fabric < ApplicationRecord
  belongs_to :type, foreign_key: :admin_fabric_type_id, class_name: '::Admin::FabricType'
  belongs_to :brand, foreign_key: :admin_fabric_brand_id, class_name: '::Admin::FabricBrand'
  
  mount_uploaders :images, ImageUploader
  
  validates_presence_of :admin_fabric_type_id, :admin_fabric_brand_id
end
