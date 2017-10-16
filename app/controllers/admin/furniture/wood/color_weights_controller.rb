class Admin::Furniture::Wood::ColorWeightsController < Admin::AdminbaseController
  before_action :set_admin_furniture_wood_color_weight, only: [:show, :edit, :update, :destroy]

  # GET /admin/furniture/wood/color_weights
  # GET /admin/furniture/wood/color_weights.json
  def index
    @admin_furniture_wood_color_weights = Admin::Furniture::Wood::ColorWeight.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_furniture_wood_color_weights.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/furniture/wood/color_weights/1
  # GET /admin/furniture/wood/color_weights/1.json
  def show
  end

  # GET /admin/furniture/wood/color_weights/new
  def new
    @admin_furniture_wood_color_weight = Admin::Furniture::Wood::ColorWeight.new
  end

  # GET /admin/furniture/wood/color_weights/1/edit
  def edit
  end

  # POST /admin/furniture/wood/color_weights
  # POST /admin/furniture/wood/color_weights.json
  def create
    @admin_furniture_wood_color_weight = Admin::Furniture::Wood::ColorWeight.new(admin_furniture_wood_color_weight_params)

    respond_to do |format|
      if @admin_furniture_wood_color_weight.save
        format.html { redirect_to admin_furniture_wood_color_weights_path, notice: mk_notice(@admin_furniture_wood_color_weight, :id, 'Color weight', :create) }
        format.json { render json: @admin_furniture_wood_color_weight, status: :created, location: admin_furniture_wood_color_weights_path }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_wood_color_weight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture/wood/color_weights/1
  # PATCH/PUT /admin/furniture/wood/color_weights/1.json
  def update
    respond_to do |format|
      if @admin_furniture_wood_color_weight.update(admin_furniture_wood_color_weight_params)
        format.html { redirect_to admin_furniture_wood_color_weights_path, notice: mk_notice(@admin_furniture_wood_color_weight, :id, 'Color weight', :update) }
        format.json { render json: @admin_furniture_wood_color_weight, status: :ok, location: admin_furniture_wood_color_weights_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_wood_color_weight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture/wood/color_weights/1
  # DELETE /admin/furniture/wood/color_weights/1.json
  def destroy
    @admin_furniture_wood_color_weight.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_wood_color_weights_path, notice: mk_notice(@admin_furniture_wood_color_weight, :id, 'Color weight', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_wood_color_weight
      @admin_furniture_wood_color_weight = Admin::Furniture::Wood::ColorWeight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_wood_color_weight_params
      params.require(:admin_furniture_wood_color_weight).permit(:name, :comment)
    end
end
