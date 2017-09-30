class ApiController < ApplicationController
  def ls_fabrics
    quality_id = params.require(:q)
    fabrics = Admin::Furniture::Fabric::Fabric.where(admin_furniture_fabric_quality_id: quality_id).map do |fabric|
      {
        comment: fabric.comment,
        models: fabric.models.map { |m| { id: m.id, origin: m.image[:image].url, thumb: m.image[:image].thumb.url } },
        quality: {
          id: fabric.quality.id,
          name: fabric.quality.name,
          comment: fabric.quality.comment
        },
        brand: {
          id: fabric.brand.id,
          name: fabric.brand.name,
          comment: fabric.brand.comment
        }
      }
    end
    respond_to do |format|
      format.json { render json: fabrics, status: :ok }
    end
  end
end
