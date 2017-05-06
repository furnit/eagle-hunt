class Admin::FurniturePaintColorsController < Admin::AdminbaseController
  before_action :set_admin_furniture_paint_color, only: [:show, :edit, :update, :destroy]

  # GET /admin/furniture_paint_colors
  # GET /admin/furniture_paint_colors.json
  def index
    @admin_furniture_paint_colors = Admin::FurniturePaintColor.all
  end

  # GET /admin/furniture_paint_colors/1
  # GET /admin/furniture_paint_colors/1.json
  def show
  end

  # GET /admin/furniture_paint_colors/new
  def new
    @admin_furniture_paint_color = Admin::FurniturePaintColor.new
  end

  # GET /admin/furniture_paint_colors/1/edit
  def edit
  end

  # POST /admin/furniture_paint_colors
  # POST /admin/furniture_paint_colors.json
  def create
    @admin_furniture_paint_color = Admin::FurniturePaintColor.new(admin_furniture_paint_color_params)

    respond_to do |format|
      if @admin_furniture_paint_color.save
        format.html { redirect_to admin_furniture_paint_colors_path, notice: "رنگ «<b>#{@admin_furniture_paint_color.name}</b>» با موفقیت ایجاد شد." }
        format.json { render json: @admin_furniture_paint_color, status: :created, location: admin_furniture_paint_colors_path }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_paint_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture_paint_colors/1
  # PATCH/PUT /admin/furniture_paint_colors/1.json
  def update
    respond_to do |format|
      if @admin_furniture_paint_color.update(admin_furniture_paint_color_params)
        format.html { redirect_to admin_furniture_paint_colors_path, notice: "رنگ «<b>#{@admin_furniture_paint_color.name}</b>» با موفقیت ایجاد شد." }
        format.json { render json: @admin_furniture_paint_color, status: :ok, location: admin_furniture_paint_colors_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_paint_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture_paint_colors/1
  # DELETE /admin/furniture_paint_colors/1.json
  def destroy
    @admin_furniture_paint_color.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_paint_colors_path, notice: "رنگ «<b>#{@admin_furniture_paint_color.name}</b>» با موفقیت ایجاد شد." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_paint_color
      @admin_furniture_paint_color = Admin::FurniturePaintColor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_paint_color_params
      params.require(:admin_furniture_paint_color).permit(:name, :admin_furniture_paint_color_qualities_id, :admin_furniture_paint_color_brands_id, :comment, :color_value, :color_details)
    end
end
