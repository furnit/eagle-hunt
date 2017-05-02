class Admin::Fabric < ParanoiaRecord
  belongs_to :type, foreign_key: :admin_fabric_type_id, class_name: '::Admin::FabricType'
  belongs_to :brand, foreign_key: :admin_fabric_brand_id, class_name: '::Admin::FabricBrand'
  
  mount_uploaders :images, ImageUploader
  # don't delete the images on soft delete
  # see: (github.com/carrierwaveuploader/carrierwave/issues/624#issuecomment-15243440)
  skip_callback :commit, :after, :remove_images!
  
  validates_presence_of :admin_fabric_type_id, :admin_fabric_brand_id
end
