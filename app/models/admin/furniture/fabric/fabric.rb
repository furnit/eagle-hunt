class Admin::Furniture::Fabric::Fabric < Admin::Uploader::Image
  
  acts_as_paranoid

  belongs_to :type, foreign_key: :admin_furniture_fabric_type_id, class_name: '::Admin::Furniture::FabricType'
  belongs_to :brand, foreign_key: :admin_furniture_fabric_brand_id, class_name: '::Admin::Furniture::FabricBrand'
  has_many   :models, foreign_key: :admin_furniture_fabric_fabric_id, class_name: '::Admin::Furniture::Fabric::Model'
  has_many :admin_furniture_fabric_color_indices, class_name: '::Admin::Furniture::FabricColorIndex', foreign_key: :admin_furniture_fabric_id, dependent: :destroy
  
  validates_presence_of :admin_furniture_fabric_type_id, :admin_furniture_fabric_brand_id
  
  # determine color types
  after_save { self.determine_colour if self.images_changed? }
  
  def determine_colour
    params = Admin::Furniture::FabricColor.select(:model).first
    
    return if params.nil?
    
    kmeans = KMeansClusterer.new(k: params.model["k"], init: params.model["init"], runs: params.model["runs"])
    
    # delete all related color to current instance
    Admin::Furniture::FabricColorIndex.delete_all(admin_furniture_fabric_id: self.id)
     
    self.images.each.with_index do |i, index|
      file = i.file.file
      fci = Admin::Furniture::FabricColorIndex.new
      fci.admin_furniture_fabric_id = self.id
      fci.admin_furniture_fabric_image = index
      fci.admin_furniture_fabric_color_id = kmeans.predict(Admin::Furniture::FabricColor.cluster_get_colours(file)).mode + 1
      fci.save 
    end
  end
end