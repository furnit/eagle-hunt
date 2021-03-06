class Admin::Furniture::Fabric::Color < ApplicationRecord
  has_many :models_color, class_name: '::Admin::Furniture::Fabric::ModelColor', foreign_key: :admin_furniture_fabric_color_id
  
  def self.cluster k, runs: nil
    colours = [];
    models = Admin::Furniture::Fabric::Model.all
    # collect all image data to cluster
    models.map { |f| f.images.map { |i| i[:image].file.file } }.flatten.each { |file| colours += cluster_get_colours(file) }
    
    centers = []
    
    kmeans = KMeansClusterer.run(k, colours, runs: runs)
    
    kmeans.clusters.each { |cluster| centers << cluster.centroid.data.to_a.each_slice(3).to_a }
    
    # delete all indexed records
    Admin::Furniture::Fabric::ModelColor.delete_all
    # delete all color cluster records
    Admin::Furniture::Fabric::Color.delete_all
    
    centers.each.with_index do |c, cindex|
      color = "#" + c.flatten.map { |i| i.to_i.to_s(16) }.map { |i| i.length == 1 ? "0#{i}" : i }.join
      Admin::Furniture::Fabric::Color.create(id: cindex + 1, value: color, model: {k: k, init: centers.map { |i| i.flatten }, runs: runs})
    end
  end
  
  def self.cluster_get_colours file
    colours = [];
    colour_sampling = AppConfig.fabric.colours.cluster.colour_sampling
    img = Magick::Image.read(file).first
    img.scale(colour_sampling[0], colour_sampling[1]).each_pixel { |pixel| colours << [pixel.red, pixel.green, pixel.blue].map { |p| p/= 256 } }
    colours
  end
end
