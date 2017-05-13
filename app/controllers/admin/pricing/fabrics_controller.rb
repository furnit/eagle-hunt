class Admin::Pricing::FabricsController < Admin::AdminbaseController
  before_action :set_admin_pricing_fabric, only: [:show, :edit, :update, :destroy]

  # GET /admin/pricing/fabrics
  # GET /admin/pricing/fabrics.json
  def index
    @admin_pricing_fabrics = Admin::Pricing::Fabric.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_pricing_fabrics.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/pricing/fabrics/1
  # GET /admin/pricing/fabrics/1.json
  def show
  end

  # GET /admin/pricing/fabrics/new
  def new
    @admin_pricing_fabric = Admin::Pricing::Fabric.new
  end

  # GET /admin/pricing/fabrics/1/edit
  def edit
  end

  # POST /admin/pricing/fabrics
  # POST /admin/pricing/fabrics.json
  def create
    @admin_pricing_fabric = Admin::Pricing::Fabric.new(admin_pricing_fabric_params)

    respond_to do |format|
      if @admin_pricing_fabric.save
        format.html { redirect_to admin_pricing_fabrics_path, notice: mk_notice(@admin_pricing_fabric, @admin_pricing_fabric.brand.name, 'برند‌ پارچه', :create) }
        format.json { render json: @admin_pricing_fabric, status: :created, location: admin_pricing_fabrics_path }
      else
        format.html { render :new }
        format.json { render json: @admin_pricing_fabric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pricing/fabrics/1
  # PATCH/PUT /admin/pricing/fabrics/1.json
  def update
    respond_to do |format|
      if @admin_pricing_fabric.update(admin_pricing_fabric_params)
        format.html { redirect_to admin_pricing_fabrics_path, notice: mk_notice(@admin_pricing_fabric, @admin_pricing_fabric.brand.name, 'برند‌ پارچه', :update) }
        format.json { render json: @admin_pricing_fabric, status: :ok, location: admin_pricing_fabrics_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_pricing_fabric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pricing/fabrics/1
  # DELETE /admin/pricing/fabrics/1.json
  def destroy
    @admin_pricing_fabric.destroy
    respond_to do |format|
      format.html { redirect_to admin_pricing_fabrics_path, notice: mk_notice(@admin_pricing_fabric, @admin_pricing_fabric.brand.name, 'برند‌ پارچه', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_pricing_fabric
      @admin_pricing_fabric = Admin::Pricing::Fabric.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_pricing_fabric_params
      params.require(:admin_pricing_fabric).permit(:admin_furniture_fabric_brand_id, :price, :comment)
    end
end
