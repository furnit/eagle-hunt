class Admin::FurnitureFabricBrandsController < Admin::AdminbaseController
  before_action :set_admin_furniture_fabric_brand, only: [:show, :edit, :update, :destroy]

  # GET /admin/fabric_brands
  # GET /admin/fabric_brands.json
  def index
    @admin_furniture_fabric_brands = Admin::FurnitureFabricBrand.paginate(page: params[:page])
    
    respond_to do |format|
      format.html
      format.json { render json: @admin_furniture_fabric_brands.map {|i| {value: i.id, text: i.name}}, status: :ok }
    end
  end

  # GET /admin/fabric_brands/1
  # GET /admin/fabric_brands/1.json
  def show
  end

  # GET /admin/fabric_brands/new
  def new
    @admin_furniture_fabric_brand = Admin::FurnitureFabricBrand.new
  end

  # GET /admin/fabric_brands/1/edit
  def edit
  end

  # POST /admin/fabric_brands
  # POST /admin/fabric_brands.json
  def create
    @admin_furniture_fabric_brand = Admin::FurnitureFabricBrand.new(admin_furniture_fabric_brand_params)

    respond_to do |format|
      if @admin_furniture_fabric_brand.save
        format.html { redirect_to admin_furniture_fabric_brands_path, notice: "برند پارچه «<b>#{@admin_furniture_fabric_brand.name}</b>» با موفقت ایجاد شد."  }
        format.json { render json: @admin_furniture_fabric_brand, status: :created, location: @admin_furniture_fabric_brand }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_fabric_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/fabric_brands/1
  # PATCH/PUT /admin/fabric_brands/1.json
  def update
    respond_to do |format|
      if @admin_furniture_fabric_brand.update(admin_furniture_fabric_brand_params)
        format.html { redirect_to admin_furniture_fabric_brands_path, notice: "برند پارچه «<b>#{@admin_furniture_fabric_brand.name}</b>» با موفقت ویرایش شد."  }
        format.json { render json: @admin_furniture_fabric_brand, status: :ok, location: @admin_furniture_fabric_brand }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_fabric_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/fabric_brands/1
  # DELETE /admin/fabric_brands/1.json
  def destroy
    @admin_furniture_fabric_brand.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_fabric_brands_url, notice: "برند پارچه «<b>#{@admin_furniture_fabric_brand.name}</b>» با موفقت حذف شد."  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_fabric_brand
      @admin_furniture_fabric_brand = Admin::FurnitureFabricBrand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_fabric_brand_params
      params.require(:admin_furniture_fabric_brand).permit(:name, :comment)
    end
end
