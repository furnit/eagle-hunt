class Admin::FurnitureFabric < ParanoiaRecord
  belongs_to :type, foreign_key: :admin_furniture_fabric_type_id, class_name: '::Admin::FurnitureFabricType'
  belongs_to :brand, foreign_key: :admin_furniture_fabric_brand_id, class_name: '::Admin::FurnitureFabricBrand'
  has_many :admin_furniture_fabric_color_indices, class_name: '::Admin::FurnitureFabricColorIndex', foreign_key: :admin_furniture_fabric_id, dependent: :destroy
  
  mount_uploaders :images, ImageUploader
  # don't delete the images on soft delete
  # see: (github.com/carrierwaveuploader/carrierwave/issues/624#issuecomment-15243440)
  skip_callback :commit, :after, :remove_images!
  
  validates_presence_of :admin_furniture_fabric_type_id, :admin_furniture_fabric_brand_id
  
  # determine color types
  after_save { self.determine_colour if self.images_changed? }
  
  def determine_colour
    params = Admin::FurnitureFabricColor.select(:model).first
    
    return if params.nil?
    
    kmeans = KMeansClusterer.new(k: params.model["k"], init: params.model["init"], runs: params.model["runs"])
    
    # delete all related color to current instance
    Admin::FurnitureFabricColorIndex.delete_all(admin_furniture_fabric_id: self.id)
     
    self.images.each.with_index do |i, index|
      file = i.file.file
      fci = Admin::FurnitureFabricColorIndex.new
      fci.admin_furniture_fabric_id = self.id
      fci.admin_furniture_fabric_image = index
      fci.admin_furniture_fabric_color_id = kmeans.predict(Admin::FurnitureFabricColor.cluster_get_colours(file)).mode + 1
      fci.save 
    end
  end
end
