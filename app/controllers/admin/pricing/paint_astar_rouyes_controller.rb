class Admin::Pricing::PaintAstarRouyesController < Admin::AdminbaseController
  before_action :set_admin_pricing_paint_astar_rouye, only: [:show, :edit, :update, :destroy]

  # GET /admin/pricing/paint_astar_rouyes
  # GET /admin/pricing/paint_astar_rouyes.json
  def index
    @admin_pricing_paint_astar_rouyes = Admin::Pricing::PaintAstarRouye.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_pricing_paint_astar_rouyes.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/pricing/paint_astar_rouyes/1
  # GET /admin/pricing/paint_astar_rouyes/1.json
  def show
  end

  # GET /admin/pricing/paint_astar_rouyes/new
  def new
    @admin_pricing_paint_astar_rouye = Admin::Pricing::PaintAstarRouye.new
  end

  # GET /admin/pricing/paint_astar_rouyes/1/edit
  def edit
  end

  # POST /admin/pricing/paint_astar_rouyes
  # POST /admin/pricing/paint_astar_rouyes.json
  def create
    @admin_pricing_paint_astar_rouye = Admin::Pricing::PaintAstarRouye.new(admin_pricing_paint_astar_rouye_params)

    respond_to do |format|
      if @admin_pricing_paint_astar_rouye.save
        format.html { redirect_to admin_pricing_paint_astar_rouyes_path, notice: mk_notice(@admin_pricing_paint_astar_rouye, :id, 'Paint astar rouye', :create) }
        format.json { render json: @admin_pricing_paint_astar_rouye, status: :created, location: admin_pricing_paint_astar_rouyes_path }
      else
        format.html { render :new }
        format.json { render json: @admin_pricing_paint_astar_rouye.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pricing/paint_astar_rouyes/1
  # PATCH/PUT /admin/pricing/paint_astar_rouyes/1.json
  def update
    respond_to do |format|
      if @admin_pricing_paint_astar_rouye.update(admin_pricing_paint_astar_rouye_params)
        format.html { redirect_to admin_pricing_paint_astar_rouyes_path, notice: mk_notice(@admin_pricing_paint_astar_rouye, :id, 'Paint astar rouye', :update) }
        format.json { render json: @admin_pricing_paint_astar_rouye, status: :ok, location: admin_pricing_paint_astar_rouyes_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_pricing_paint_astar_rouye.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pricing/paint_astar_rouyes/1
  # DELETE /admin/pricing/paint_astar_rouyes/1.json
  def destroy
    @admin_pricing_paint_astar_rouye.destroy
    respond_to do |format|
      format.html { redirect_to admin_pricing_paint_astar_rouyes_path, notice: mk_notice(@admin_pricing_paint_astar_rouye, :id, 'Paint astar rouye', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_pricing_paint_astar_rouye
      @admin_pricing_paint_astar_rouye = Admin::Pricing::PaintAstarRouye.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_pricing_paint_astar_rouye_params
      params.require(:admin_pricing_paint_astar_rouye).permit(:astare_avaliye, :astare_asli, :rouye, :batune)
    end
end
