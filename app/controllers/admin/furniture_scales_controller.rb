class Admin::FurnitureScalesController < Admin::AdminbaseController
  before_action :set_admin_furniture_scale, only: [:show, :edit, :update, :destroy]

  # GET /admin/furniture_scales
  # GET /admin/furniture_scales.json
  def index
    @admin_furniture_scales = Admin::FurnitureScale.all
  end

  # GET /admin/furniture_scales/new
  def new
    @admin_furniture_scale = Admin::FurnitureScale.new
  end

  # GET /admin/furniture_scales/1/edit
  def edit
  end

  # POST /admin/furniture_scales
  # POST /admin/furniture_scales.json
  def create
    @admin_furniture_scale = Admin::FurnitureScale.new(admin_furniture_scale_params)

    respond_to do |format|
      if @admin_furniture_scale.save
        format.html { redirect_to admin_furniture_scales_path, notice: "مقیاس «<b>#{@admin_furniture_scale.name}</b>» با موفقیت ایجاد شد."}
        format.json { render json: @admin_furniture_scale, status: :created, location: @admin_furniture_scale }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_scale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture_scales/1
  # PATCH/PUT /admin/furniture_scales/1.json
  def update
    respond_to do |format|
      if @admin_furniture_scale.update(admin_furniture_scale_params)
        format.html { redirect_to admin_furniture_scales_path, notice: "مقیاس «<b>#{@admin_furniture_scale.name}</b>» با موفقیت ویرایش شد."}
        format.json { render json: @admin_furniture_scale, status: :ok, location: @admin_furniture_scale }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_scale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture_scales/1
  # DELETE /admin/furniture_scales/1.json
  def destroy
    @admin_furniture_scale.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_scales_path, notice: "مقیاس «<b>#{@admin_furniture_scale.name}</b>» با موفقیت حذف شد."}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_scale
      @admin_furniture_scale = Admin::FurnitureScale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_scale_params
      params.require(:admin_furniture_scale).permit(:name, :comment)
    end
end
