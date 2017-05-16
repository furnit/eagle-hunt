class Admin::Selling::Config::PricesController < Admin::AdminbaseController
  before_action :validate_params, only: [:update]
  before_action :set_admin_selling_config_price, only: [:show, :edit, :update, :destroy]
  before_action :set_editional_data, only: [:new, :edit]

  # GET /admin/selling/config/prices
  # GET /admin/selling/config/prices.json
  def index
    @admin_selling_config_prices = Admin::Selling::Config::Price.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_selling_config_prices.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/selling/config/prices/1
  # GET /admin/selling/config/prices/1.json
  def show
  end

  # GET /admin/selling/config/prices/new
  def new
    @admin_selling_config_price = Admin::Selling::Config::Price.new
  end

  # GET /admin/selling/config/prices/1/edit
  def edit
  end

  # POST /admin/selling/config/prices
  # POST /admin/selling/config/prices.json
  def create
    @admin_selling_config_price = Admin::Selling::Config::Price.new(admin_selling_config_price_params)
    respond_to do |format|
      if @admin_selling_config_price.save
        format.html { redirect_to admin_furniture_furnitures_path, notice: mk_notice(@admin_selling_config_price, @furniture.name, 'تنظیمات قیمت‌گذاری', :create) }
        format.json { render json: @admin_selling_config_price, status: :created, location: admin_furniture_furnitures_path }
      else
        format.html { render :new }
        format.json { render json: @admin_selling_config_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/selling/config/prices/1
  # PATCH/PUT /admin/selling/config/prices/1.json
  def update
    overall_cost = ComputePrice.execute(@furniture, set: @set, **compute_price_params)
    respond_to do |format|
      if @admin_selling_config_price.update(admin_selling_config_price_params.to_h.merge({ overall_cost: overall_cost }))
        @furniture.update_attributes(available: true)
        format.html { redirect_to admin_furniture_furnitures_path, notice: mk_notice(@admin_selling_config_price, @furniture.name, 'تنظیمات قیمت‌گذاری', :update) }
        format.json { render json: @admin_selling_config_price, status: :ok, location: admin_furniture_furnitures_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_selling_config_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/selling/config/prices/1
  # DELETE /admin/selling/config/prices/1.json
  def destroy
    @admin_selling_config_price.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_furnitures_path, notice: mk_notice(@admin_selling_config_price, @furniture.name, 'تنظیمات قیمت‌گذاری', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    def validate_params
      _validates = [
        params[:id],
        params[:hd],
        params[:hd] == get_hash(params[:id]) 
      ]
      raise Acu::Errors::AccessDenied.new("invalid params") if not _validates.all?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_selling_config_price
      @furniture = Admin::Furniture::Furniture.where(id: params[:id], ready_for_pricing: true).first
      raise ActiveRecord::RecordNotFound.new("furniture# #{params[:id]} not found or not ready for pricing!") if @furniture.nil?
      @set = Admin::Furniture::Set.find(admin_selling_config_price_params[:admin_furniture_set_id]).config if params["action"] == "update"
      @admin_selling_config_price = Admin::Selling::Config::Price.find_or_create_by(admin_furniture_furniture_id: @furniture.id)
    end
    
    def set_editional_data
      overall = Employee::Overall.find_by(admin_furniture_furniture_id: params[:id])
      @fabrics = Admin::Pricing::Fabric.all
      @paint_colors = overall.fani_needs_rang? ? Admin::Pricing::PaintColor.all : nil
      @woods = overall.fani_needs_kande? ? Admin::Pricing::Wood.all : nil
    end
    
    def compute_price_params
      out = { }
      par = admin_selling_config_price_params.to_h.symbolize_keys.select { |k| [:admin_furniture_fabric_brand_id, :admin_furniture_paint_color_brand_id, :admin_furniture_wood_type_id].include? k }
      par.each do |k, p|
        out[k.to_s.gsub(/admin_furniture_/, "").to_sym] = p
      end
      out
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_selling_config_price_params
      params.require(:furniture_config).permit(:admin_furniture_set_id, :admin_furniture_fabric_brand_id, :admin_furniture_paint_color_brand_id, :admin_furniture_wood_type_id)
    end
end
