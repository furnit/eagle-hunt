class Admin::FurnitureColorBrandsController < ApplicationController
  before_action :set_admin_furniture_color_brand, only: [:show, :edit, :update, :destroy]

  # GET /admin/furniture_color_brands
  # GET /admin/furniture_color_brands.json
  def index
    @admin_furniture_color_brands = Admin::FurnitureColorBrand.all
  end

  # GET /admin/furniture_color_brands/1
  # GET /admin/furniture_color_brands/1.json
  def show
  end

  # GET /admin/furniture_color_brands/new
  def new
    @admin_furniture_color_brand = Admin::FurnitureColorBrand.new
  end

  # GET /admin/furniture_color_brands/1/edit
  def edit
  end

  # POST /admin/furniture_color_brands
  # POST /admin/furniture_color_brands.json
  def create
    @admin_furniture_color_brand = Admin::FurnitureColorBrand.new(admin_furniture_color_brand_params)

    respond_to do |format|
      if @admin_furniture_color_brand.save
        format.html { redirect_to @admin_furniture_color_brand, notice: 'Furniture color brand was successfully created.' }
        format.json { render :show, status: :created, location: @admin_furniture_color_brand }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_color_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture_color_brands/1
  # PATCH/PUT /admin/furniture_color_brands/1.json
  def update
    respond_to do |format|
      if @admin_furniture_color_brand.update(admin_furniture_color_brand_params)
        format.html { redirect_to @admin_furniture_color_brand, notice: 'Furniture color brand was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_furniture_color_brand }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_color_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture_color_brands/1
  # DELETE /admin/furniture_color_brands/1.json
  def destroy
    @admin_furniture_color_brand.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_color_brands_url, notice: 'Furniture color brand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_color_brand
      @admin_furniture_color_brand = Admin::FurnitureColorBrand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_color_brand_params
      params.require(:admin_furniture_color_brand).permit(:name, :comment)
    end
end
