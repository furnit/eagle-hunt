class Admin::Furniture::Fabric::QualitiesController < Admin::AdminbaseController
  before_action :set_admin_furniture_fabric_quality, only: [:show, :edit, :update, :destroy]

  # GET /admin/furniture/fabric/qualities
  # GET /admin/furniture/fabric/qualities.json
  def index
    @admin_furniture_fabric_qualities = Admin::Furniture::Fabric::Quality.paginate(page: params[:page])
    
    respond_to do |format|
      format.html
      format.json { render json: @admin_furniture_fabric_qualities.map {|i| {value: i.id, text: i.name}}, status: :ok }
    end
  end

  # GET /admin/furniture/fabric/qualities/1
  # GET /admin/furniture/fabric/qualities/1.json
  def show
  end

  # GET /admin/furniture/fabric/qualities/new
  def new
    @admin_furniture_fabric_quality = Admin::Furniture::Fabric::Quality.new
  end

  # GET /admin/furniture/fabric/qualities/1/edit
  def edit
  end

  # POST /admin/furniture/fabric/qualities
  # POST /admin/furniture/fabric/qualities.json
  def create
    @admin_furniture_fabric_quality = Admin::Furniture::Fabric::Quality.new(admin_furniture_fabric_quality_params)

    respond_to do |format|
      if @admin_furniture_fabric_quality.save
        format.html { redirect_to admin_furniture_fabric_qualities_path, notice: "نوع پارچه «<b>#{@admin_furniture_fabric_quality.name}</b>» با موفقیت ایجاد شد." }
        format.json { render json: @admin_furniture_fabric_quality, status: :created, location: admin_furniture_fabric_qualities_path }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_fabric_quality.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture/fabric/qualities/1
  # PATCH/PUT /admin/furniture/fabric/qualities/1.json
  def update
    respond_to do |format|
      if @admin_furniture_fabric_quality.update(admin_furniture_fabric_quality_params)
        format.html { redirect_to admin_furniture_fabric_qualities_path, notice: "نوع پارچه «<b>#{@admin_furniture_fabric_quality.name}</b>» با موفقیت ویرایش شد." }
        format.json { render json: @admin_furniture_fabric_quality, status: :ok, location: admin_furniture_fabric_qualities_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_fabric_quality.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture/fabric/qualities/1
  # DELETE /admin/furniture/fabric/qualities/1.json
  def destroy
    @admin_furniture_fabric_quality.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_fabric_qualities_path, notice: "نوع پارچه «<b>#{@admin_furniture_fabric_quality.name}</b>» با موفقیت حذف شد." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_fabric_quality
      @admin_furniture_fabric_quality = Admin::Furniture::Fabric::Quality.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_fabric_quality_params
      params.require(:admin_furniture_fabric_quality).permit(:name, :comment)
    end
end
