class Admin::Pricing::ComputesController < ApplicationController
  before_action :set_furniture, only: [:index]
  before_action :validate_params
  before_action :fetch_set_prices

  # GET /admin/pricing/computes
  # GET /admin/pricing/computes.json
  def index
    # return if no workable info defined?
    return if (admin_pricing_compute_params.keys & [:fabric_brand_id, :paint_color_brand_id, :wood_type_id].map(&:to_s)).length == 0
    # get all pieces together
    set_pieces = Hash[@set.map {|x| [x, Admin::Selling::Config::PiecePrice.find_by(piece: x)]}]
    # if not all pieces' price not defined? 
    if not set_pieces.values.all?
      respond_with_error "یک یا چند عدد از مشخصات ست مورد نظر، قیمت‌گذاری نشده است."
      return
    end
    # get all factors together
    factors = {
      fabric: Admin::Pricing::Fabric.find_by(admin_furniture_fabric_brand_id: admin_pricing_compute_params[:fabric_brand_id]),
      paint_color: Admin::Pricing::PaintColor.find_by(admin_furniture_paint_color_brand_id: admin_pricing_compute_params[:paint_color_brand_id]),
      wood: Admin::Pricing::Wood.find_by(admin_furniture_wood_type_id: admin_pricing_compute_params[:wood_type_id]),
      kalaf: Admin::Pricing::Kalaf.last
    }
    # compute cost based on factors 
    base_cost = @furniture.compute_cost **factors
    prices = Hash[@set.map {|x| [x, 0]}]
    cost = 0
    @set.each { |s| cost += (base_cost * set_pieces[s].percentage) }
    respond_with_success cost
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_furniture
      @furniture = Admin::Furniture::Furniture.find(params[:compute_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_pricing_compute_params
      params.require(:furniture_config).permit(:set_id, :fabric_brand_id, :wood_type_id, :paint_color_brand_id, set_config: [])
    end
    
    def validate_params
      notvalid = [
        # if non-exists?
        not(admin_pricing_compute_params[:set_id] or (admin_pricing_compute_params[:set_config] or admin_pricing_compute_params[:set_config].empty?)),
        # if both exist?
        (admin_pricing_compute_params[:set_id] and admin_pricing_compute_params[:set_config] and not(admin_pricing_compute_params[:set_config].empty?))
      ]
      raise Acu::Errors::AccessDenied.new('invalid params') if notvalid.any?
    end
    
    def fetch_set_prices
      @set = Admin::Furniture::Set.find(admin_pricing_compute_params[:set_id]).config if admin_pricing_compute_params[:set_id]
      @set = admin_pricing_compute_params[:set_config] if admin_pricing_compute_params[:set_config] and not admin_pricing_compute_params[:set_config].empty?
    end
    
    def respond_with_error message
      respond_to do |format|
        format.json { render json: { status: :error, message: message }, status: :unprocessable_entity }
      end
    end
    def respond_with_success cost
      respond_to do |format|
        format.json { render json: { status: :ok, cost: cost }, status: :ok }
      end
    end
end
