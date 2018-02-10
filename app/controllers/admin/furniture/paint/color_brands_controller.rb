class Admin::Furniture::Paint::ColorBrandsController < Admin::AdminbaseController
  before_action :set_admin_furniture_paint_color_brand, only: [:show, :edit, :update, :destroy]

  # GET /admin/furniture_paint_color_brands
  # GET /admin/furniture_paint_color_brands.json
  def index
    @admin_furniture_paint_color_brands = Admin::Furniture::Paint::ColorBrand.all

    respond_to do |format|
      format.html { }
      format.json { render json: @admin_furniture_paint_color_brands.map {|i| {value: i.id, text: i.name}}, status: :ok }
    end
  end

  # GET /admin/furniture_paint_color_brands/1
  # GET /admin/furniture_paint_color_brands/1.json
  def show
  end

  # GET /admin/furniture_paint_color_brands/new
  def new
    @admin_furniture_paint_color_brand = Admin::Furniture::Paint::ColorBrand.new
  end

  # GET /admin/furniture_paint_color_brands/1/edit
  def edit
  end

  # POST /admin/furniture_paint_color_brands
  # POST /admin/furniture_paint_color_brands.json
  def create
    @admin_furniture_paint_color_brand = Admin::Furniture::Paint::ColorBrand.new(admin_furniture_paint_color_brand_params)

    respond_to do |format|
      if @admin_furniture_paint_color_brand.save
        # make it default if required
        make_default_if_required @admin_furniture_paint_color_brand
        format.html { redirect_to admin_furniture_paint_color_brands_path, notice: "کیفیت رنگ «<b>#{@admin_furniture_paint_color_brand.name}</b>» با موفقیت ایجاد شد." }
        format.json { render json: @admin_furniture_paint_color_brand, status: :created, location: admin_furniture_paint_color_brands_path }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_paint_color_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture_paint_color_brands/1
  # PATCH/PUT /admin/furniture_paint_color_brands/1.json
  def update
    respond_to do |format|
      if @admin_furniture_paint_color_brand.update(admin_furniture_paint_color_brand_params)
        # make it default if required
        make_default_if_required @admin_furniture_paint_color_brand
        format.html { redirect_to admin_furniture_paint_color_brands_path, notice: "کیفیت رنگ «<b>#{@admin_furniture_paint_color_brand.name}</b>» با موفقیت ویرایش شد." }
        format.json { render json: @admin_furniture_paint_color_brand, status: :ok, location: @admin_furniture_paint_color_brand }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_paint_color_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture_paint_color_brands/1
  # DELETE /admin/furniture_paint_color_brands/1.json
  def destroy
    @admin_furniture_paint_color_brand.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_paint_color_brands_path, notice: "کیفیت رنگ «<b>#{@admin_furniture_paint_color_brand.name}</b>» با موفقیت حذف شد." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_paint_color_brand
      @admin_furniture_paint_color_brand = Admin::Furniture::Paint::ColorBrand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_paint_color_brand_params
      params.require(:admin_furniture_paint_color_brand).permit(:name, :comment, :is_default)
    end

    def make_default_if_required ins
      if ins.is_default
        Admin::Furniture::Paint::ColorBrand.where("is_default = true and id != ?", ins).update_all(is_default: false)
      end
    end
end
