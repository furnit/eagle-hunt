class Admin::Pricing::ComputesController < Admin::AdminbaseController
  before_action :set_furniture, only: [:index]
  before_action :validate_params
  before_action :fetch_set_prices

  # GET /admin/pricing/computes
  # GET /admin/pricing/computes.json
  def index
    # expecting to have @set ready
    raise RuntimeError.new("ابتدا نوع ست مورد نظر خود را وارد کنید.") if not @set
    # return if no workable info defined?
    return if not admin_pricing_compute_params.select { |k| [:fabric_brand_id, :paint_color_brand_id, :wood_type_id].include? k.to_sym }.values.map(&:numeric?).any?
    # compute the cost
    cost = ComputePrice.execute(@furniture, set: @set, **admin_pricing_compute_params.to_h.symbolize_keys.select { |k| [:fabric_brand_id, :paint_color_brand_id, :wood_type_id].include? k })
    # respond the cost
    respond_with_success cost.to_i.to_s.to_money
    # if anything occured
  rescue RuntimeError => e
    respond_with_error e.message
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
    rescue ActiveRecord::RecordNotFound
      @set = nil
    end
    
    def respond_with_error message
      respond_to do |format|
        format.json { render json: { status: :error, message: message }, status: :unprocessable_entity }
      end
    end
    def respond_with_success cost
      respond_to do |format|
        format.json { render json: { status: :ok, cost: cost, hash: get_hash(cost) }, status: :ok }
      end
    end
end
