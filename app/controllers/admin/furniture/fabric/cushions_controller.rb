class Admin::Furniture::Fabric::CushionsController < Admin::AdminbaseController
  before_action :set_admin_furniture_fabric_cushion, only: [:show, :edit, :update, :destroy]

  # GET /admin/furniture/fabric/cushions
  # GET /admin/furniture/fabric/cushions.json
  def index
    @admin_furniture_fabric_cushions = Admin::Furniture::Fabric::Cushion.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_furniture_fabric_cushions.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/furniture/fabric/cushions/1
  # GET /admin/furniture/fabric/cushions/1.json
  def show
  end

  # GET /admin/furniture/fabric/cushions/new
  def new
    @admin_furniture_fabric_cushion = Admin::Furniture::Fabric::Cushion.new
  end

  # GET /admin/furniture/fabric/cushions/1/edit
  def edit
  end

  # POST /admin/furniture/fabric/cushions
  # POST /admin/furniture/fabric/cushions.json
  def create
    @admin_furniture_fabric_cushion = Admin::Furniture::Fabric::Cushion.new(admin_furniture_fabric_cushion_params)

    respond_to do |format|
      if @admin_furniture_fabric_cushion.save
        format.html { redirect_to admin_furniture_fabric_cushions_path, notice: mk_notice(@admin_furniture_fabric_cushion, :label, 'کوسن', :create) }
        format.json { render json: @admin_furniture_fabric_cushion, status: :created, location: admin_furniture_fabric_cushions_path }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_fabric_cushion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture/fabric/cushions/1
  # PATCH/PUT /admin/furniture/fabric/cushions/1.json
  def update
    respond_to do |format|
      if @admin_furniture_fabric_cushion.update(admin_furniture_fabric_cushion_params)
        format.html { redirect_to admin_furniture_fabric_cushions_path, notice: mk_notice(@admin_furniture_fabric_cushion, :label, 'کوسن', :update) }
        format.json { render json: @admin_furniture_fabric_cushion, status: :ok, location: admin_furniture_fabric_cushions_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_fabric_cushion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture/fabric/cushions/1
  # DELETE /admin/furniture/fabric/cushions/1.json
  def destroy
    @admin_furniture_fabric_cushion.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_fabric_cushions_path, notice: mk_notice(@admin_furniture_fabric_cushion, :label, 'کوسن', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_fabric_cushion
      @admin_furniture_fabric_cushion = Admin::Furniture::Fabric::Cushion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_fabric_cushion_params
      params.require(:admin_furniture_fabric_cushion).permit(:label, :width, :height, :comment)
    end
end
