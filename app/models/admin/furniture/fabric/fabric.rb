class Admin::Furniture::Fabric::Fabric < Admin::Uploader::Image
  
  acts_as_paranoid

  belongs_to :type, foreign_key: :admin_furniture_fabric_quality_id, class_name: '::Admin::Furniture::Fabric::Quality'
  belongs_to :brand, foreign_key: :admin_furniture_fabric_brand_id, class_name: '::Admin::Furniture::Fabric::Brand'
  has_many   :models, foreign_key: :admin_furniture_fabric_fabric_id, class_name: '::Admin::Furniture::Fabric::Model', dependent: :destroy
  
  validates_presence_of :admin_furniture_fabric_quality_id, :admin_furniture_fabric_brand_id
  
  # determine color types
  after_save { self.determine_colour if self.images_changed? }
  
  def determine_colour
    params = Admin::Furniture::FabricColor.select(:model).first
    
    return if params.nil?
    
    kmeans = KMeansClusterer.new(k: params.model["k"], init: params.model["init"], runs: params.model["runs"])
    
    # delete all related color to current instance
    Admin::Furniture::Fabric::ModelColor.delete_all(model: self.models)
     
    self.models.each.with_index do |model, index|
      file = model.image[:image].file.file
      Admin::Furniture::Fabric::ModelColor.create!(model: model, color: Admin::Furniture::FabricColor.find(kmeans.predict(Admin::Furniture::FabricColor.cluster_get_colours(file)).mode + 1))
    end
  end
end