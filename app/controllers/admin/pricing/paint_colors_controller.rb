class Admin::Pricing::PaintColorsController < Admin::AdminbaseController
  before_action :set_admin_pricing_paint_color, only: [:show, :edit, :update, :destroy]

  # GET /admin/pricing/paint_colors
  # GET /admin/pricing/paint_colors.json
  def index
    @admin_pricing_paint_colors = Admin::Pricing::PaintColor.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_pricing_paint_colors.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/pricing/paint_colors/1
  # GET /admin/pricing/paint_colors/1.json
  def show
  end

  # GET /admin/pricing/paint_colors/new
  def new
    @admin_pricing_paint_color = Admin::Pricing::PaintColor.new
  end

  # GET /admin/pricing/paint_colors/1/edit
  def edit
  end

  # POST /admin/pricing/paint_colors
  # POST /admin/pricing/paint_colors.json
  def create
    @admin_pricing_paint_color = Admin::Pricing::PaintColor.new(admin_pricing_paint_color_params)

    respond_to do |format|
      if @admin_pricing_paint_color.save
        format.html { redirect_to admin_pricing_paint_colors_path, notice: mk_notice(@admin_pricing_paint_color, @admin_pricing_paint_color.brand.name, 'قیمت برای برند رنگ', :create) }
        format.json { render json: @admin_pricing_paint_color, status: :created, location: admin_pricing_paint_colors_path }
      else
        format.html { render :new }
        format.json { render json: @admin_pricing_paint_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pricing/paint_colors/1
  # PATCH/PUT /admin/pricing/paint_colors/1.json
  def update
    respond_to do |format|
      if @admin_pricing_paint_color.update(admin_pricing_paint_color_params)
        format.html { redirect_to admin_pricing_paint_colors_path, notice: mk_notice(@admin_pricing_paint_color, @admin_pricing_paint_color.brand.name, 'قیمت برای برند رنگ', :update) }
        format.json { render json: @admin_pricing_paint_color, status: :ok, location: admin_pricing_paint_colors_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_pricing_paint_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pricing/paint_colors/1
  # DELETE /admin/pricing/paint_colors/1.json
  def destroy
    @admin_pricing_paint_color.destroy
    respond_to do |format|
      format.html { redirect_to admin_pricing_paint_colors_path, notice: mk_notice(@admin_pricing_paint_color, @admin_pricing_paint_color.brand.name, 'قیمت برای برند رنگ', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_pricing_paint_color
      @admin_pricing_paint_color = Admin::Pricing::PaintColor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_pricing_paint_color_params
      params.require(:admin_pricing_paint_color).permit(:admin_furniture_paint_color_brand_id, :price, :comment)
    end
end
