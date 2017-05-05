class Admin::FurnitureColorsController < ApplicationController
  before_action :set_admin_furniture_color, only: [:show, :edit, :update, :destroy]

  # GET /admin/furniture_colors
  # GET /admin/furniture_colors.json
  def index
    @admin_furniture_colors = Admin::FurnitureColor.all
  end

  # GET /admin/furniture_colors/1
  # GET /admin/furniture_colors/1.json
  def show
  end

  # GET /admin/furniture_colors/new
  def new
    @admin_furniture_color = Admin::FurnitureColor.new
  end

  # GET /admin/furniture_colors/1/edit
  def edit
  end

  # POST /admin/furniture_colors
  # POST /admin/furniture_colors.json
  def create
    @admin_furniture_color = Admin::FurnitureColor.new(admin_furniture_color_params)

    respond_to do |format|
      if @admin_furniture_color.save
        format.html { redirect_to @admin_furniture_color, notice: 'Furniture color was successfully created.' }
        format.json { render :show, status: :created, location: @admin_furniture_color }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture_colors/1
  # PATCH/PUT /admin/furniture_colors/1.json
  def update
    respond_to do |format|
      if @admin_furniture_color.update(admin_furniture_color_params)
        format.html { redirect_to @admin_furniture_color, notice: 'Furniture color was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_furniture_color }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture_colors/1
  # DELETE /admin/furniture_colors/1.json
  def destroy
    @admin_furniture_color.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_colors_url, notice: 'Furniture color was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_color
      @admin_furniture_color = Admin::FurnitureColor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_color_params
      params.require(:admin_furniture_color).permit(:admin_furniture_color_qualities_id, :admin_furniture_color_brand_id, :comment, :color_value, :color_details)
    end
end
