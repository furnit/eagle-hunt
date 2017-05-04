class Admin::FurnitureFabricTypesController < Admin::AdminbaseController
  before_action :set_admin_furniture_fabric_type, only: [:show, :edit, :update, :destroy]

  # GET /admin/fabric_types
  # GET /admin/fabric_types.json
  def index
    @admin_furniture_fabric_types = Admin::FurnitureFabricType.paginate(page: params[:page])
    
    respond_to do |format|
      format.html
      format.json { render json: @admin_furniture_fabric_types.map {|i| {value: i.id, text: i.name}}, status: :ok }
    end
  end

  # GET /admin/fabric_types/1
  # GET /admin/fabric_types/1.json
  def show
  end

  # GET /admin/fabric_types/new
  def new
    @admin_furniture_fabric_type = Admin::FurnitureFabricType.new
  end

  # GET /admin/fabric_types/1/edit
  def edit
  end

  # POST /admin/fabric_types
  # POST /admin/fabric_types.json
  def create
    @admin_furniture_fabric_type = Admin::FurnitureFabricType.new(admin_furniture_fabric_type_params)

    respond_to do |format|
      if @admin_furniture_fabric_type.save
        format.html { redirect_to admin_furniture_fabric_types_path, notice: "نوع پارچه «<b>#{@admin_furniture_fabric_type.name}</b>» با موفقت ایجاد شد." }
        format.json { render json: @admin_furniture_fabric_type, status: :created, location: @admin_furniture_fabric_type }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_fabric_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/fabric_types/1
  # PATCH/PUT /admin/fabric_types/1.json
  def update
    respond_to do |format|
      if @admin_furniture_fabric_type.update(admin_furniture_fabric_type_params)
        format.html { redirect_to admin_furniture_fabric_types_path, notice: "نوع پارچه «<b>#{@admin_furniture_fabric_type.name}</b>» با موفقت ویرایش شد." }
        format.json { render json: @admin_furniture_fabric_type, status: :ok, location: @admin_furniture_fabric_type }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_fabric_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/fabric_types/1
  # DELETE /admin/fabric_types/1.json
  def destroy
    @admin_furniture_fabric_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_fabric_types_path, notice: "نوع پارچه «<b>#{@admin_furniture_fabric_type.name}</b>» با موفقت حذف شد." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_fabric_type
      @admin_furniture_fabric_type = Admin::FurnitureFabricType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_fabric_type_params
      params.require(:admin_furniture_fabric_type).permit(:name, :comment)
    end
end
