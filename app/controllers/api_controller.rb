class ApiController < ApplicationController
  def ls_fabrics
    quality_id = params.require(:q)
    # limit 1 brand for each quality
    fabrics = Admin::Furniture::Fabric::Fabric.where(admin_furniture_fabric_quality_id: quality_id).paginate(page: params[:page], per_page: 1).map do |fabric|
      build_fabric_detail fabric, fabric.models
    end

    # prepend the meta data
    fabrics = [ {
      meta: {
        total_size: Admin::Furniture::Fabric::Fabric.where(admin_furniture_fabric_quality_id: quality_id).count,
        current_page: params[:page] || 1,
        per_page: 1
      }
    } ] + fabrics

    respond_to do |format|
      format.json { render json: fabrics, status: :ok }
    end
  end

  def ls_fabric_models
    color_code = params.require(:cc)

    all = Admin::Furniture::Fabric::Color.find(color_code).related_models.map do |model|
      build_fabric_detail model.fabric, model
    end

    brands = all.map { |f| f[:brand] }.uniq

    fabrics = { }

    all.each do |f|
      if not fabrics.key? f[:brand]
        fabrics[f[:brand]] = f
      else
        fabrics[f[:brand]][:models] += f[:models]
      end
    end

    fabrics = fabrics.values

    # prepend the meta data
	  # we won't paginate in here
    fabrics = [ {
      meta: {
        total_size: fabrics.length,
        current_page: 1,
        per_page: fabrics.length
      }
    } ] + fabrics

    respond_to do |format|
      format.json { render json: fabrics, status: :ok }
    end
  end

  def transit_price
    price    = 0
    method   = params.require :method
    state_id = params.require :state_id

    case method.downcase.to_sym
    when :max
      price  = Admin::Pricing::Transit.where(state_id: state_id).pluck(:price).max
    when :min
      price  = Admin::Pricing::Transit.where(state_id: state_id).pluck(:price).min
    when :place
      price  = Admin::Pricing::Transit.where(state_id: state_id, admin_workshop_workshop_id: params.require(:workshop_id)).pluck(:price).first
    else
      raise RuntimeError.new("invalid method `#{method}`");
    end

    respond_to do |format|
      format.json { render json: { method: method, price: price.to_s.to_money }, status: :ok }
    end
  end

  protected
    def build_fabric_detail fabric, models
      models = [models].flatten
      {
        price: fabric.price,
        comment: fabric.comment,
        models: models.map { |m| { id: m.id, name: m.public_name, origin: m.image[:image].url, thumb: m.image[:image].thumb.url } },
        quality: {
          id: fabric.quality.id,
          name: fabric.quality.name,
          comment: fabric.quality.comment
        },
        brand: {
          id: fabric.brand.id,
          name: fabric.brand.name,
          comment: fabric.brand.comment,
          available: fabric.brand.available
        }
      }
    end
end
