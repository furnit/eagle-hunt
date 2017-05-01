class Admin::FabricTypesController < Admin::AdminbaseController
  before_action :set_admin_fabric_type, only: [:show, :edit, :update, :destroy]

  # GET /admin/fabric_types
  # GET /admin/fabric_types.json
  def index
    @admin_fabric_types = Admin::FabricType.paginate(page: params[:page])
  end

  # GET /admin/fabric_types/1
  # GET /admin/fabric_types/1.json
  def show
  end

  # GET /admin/fabric_types/new
  def new
    @admin_fabric_type = Admin::FabricType.new
  end

  # GET /admin/fabric_types/1/edit
  def edit
  end

  # POST /admin/fabric_types
  # POST /admin/fabric_types.json
  def create
    @admin_fabric_type = Admin::FabricType.new(admin_fabric_type_params)

    respond_to do |format|
      if @admin_fabric_type.save
        format.html { redirect_to admin_fabric_types_path, notice: "نوع پارچه «<b>#{@admin_fabric_type.name}</b>» با موفقت ایجاد شد." }
        format.json { render json: @admin_fabric_type, status: :created, location: @admin_fabric_type }
      else
        format.html { render :new }
        format.json { render json: @admin_fabric_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/fabric_types/1
  # PATCH/PUT /admin/fabric_types/1.json
  def update
    respond_to do |format|
      if @admin_fabric_type.update(admin_fabric_type_params)
        format.html { redirect_to admin_fabric_types_path, notice: "نوع پارچه «<b>#{@admin_fabric_type.name}</b>» با موفقت ویرایش شد." }
        format.json { render json: @admin_fabric_type, status: :ok, location: @admin_fabric_type }
      else
        format.html { render :edit }
        format.json { render json: @admin_fabric_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/fabric_types/1
  # DELETE /admin/fabric_types/1.json
  def destroy
    @admin_fabric_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_fabric_types_path, notice: "نوع پارچه «<b>#{@admin_fabric_type.name}</b>» با موفقت حذف شد." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_fabric_type
      @admin_fabric_type = Admin::FabricType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_fabric_type_params
      params.require(:admin_fabric_type).permit(:name, :comment)
    end
end
