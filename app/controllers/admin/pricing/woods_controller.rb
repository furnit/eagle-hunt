class Admin::Pricing::WoodsController < Admin::AdminbaseController
  before_action :set_admin_pricing_wood, only: [:show, :edit, :update, :destroy]

  # GET /admin/pricing/woods
  # GET /admin/pricing/woods.json
  def index
    @admin_pricing_woods = Admin::Pricing::Wood.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_pricing_woods.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/pricing/woods/1
  # GET /admin/pricing/woods/1.json
  def show
  end

  # GET /admin/pricing/woods/new
  def new
    @admin_pricing_wood = Admin::Pricing::Wood.new
  end

  # GET /admin/pricing/woods/1/edit
  def edit
  end

  # POST /admin/pricing/woods
  # POST /admin/pricing/woods.json
  def create
    @admin_pricing_wood = Admin::Pricing::Wood.new(admin_pricing_wood_params)

    respond_to do |format|
      if @admin_pricing_wood.save
        format.html { redirect_to admin_pricing_woods_path, notice: mk_notice(@admin_pricing_wood, @admin_pricing_wood.type.name, 'قیمت چوب', :create) }
        format.json { render json: @admin_pricing_wood, status: :created, location: admin_pricing_woods_path }
      else
        format.html { render :new }
        format.json { render json: @admin_pricing_wood.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pricing/woods/1
  # PATCH/PUT /admin/pricing/woods/1.json
  def update
    respond_to do |format|
      if @admin_pricing_wood.update(admin_pricing_wood_params)
        format.html { redirect_to admin_pricing_woods_path, notice: mk_notice(@admin_pricing_wood, @admin_pricing_wood.type.name, 'قیمت چوب', :update) }
        format.json { render json: @admin_pricing_wood, status: :ok, location: admin_pricing_woods_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_pricing_wood.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pricing/woods/1
  # DELETE /admin/pricing/woods/1.json
  def destroy
    @admin_pricing_wood.destroy
    respond_to do |format|
      format.html { redirect_to admin_pricing_woods_path, notice: mk_notice(@admin_pricing_wood, @admin_pricing_wood.type.name, 'قیمت چوب', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_pricing_wood
      @admin_pricing_wood = Admin::Pricing::Wood.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_pricing_wood_params
      params.require(:admin_pricing_wood).permit(:admin_furniture_wood_type_id, :price, :comment)
    end
end
