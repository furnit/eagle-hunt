class Admin::Furniture::Fabric::Model < Admin::Uploader::Image
  belongs_to :fabric, foreign_key: :admin_furniture_fabric_fabric_id, class_name: '::Admin::Furniture::Fabric::Fabric'
end
