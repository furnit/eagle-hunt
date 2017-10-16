class Admin::Furniture::Wood::ColorsController < Admin::AdminbaseController
  before_action :set_admin_furniture_wood_color, only: [:show, :edit, :update, :destroy]

  # GET /admin/furniture/wood/colors
  # GET /admin/furniture/wood/colors.json
  def index
    @admin_furniture_wood_colors = Admin::Furniture::Wood::Color.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_furniture_wood_colors.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/furniture/wood/colors/1
  # GET /admin/furniture/wood/colors/1.json
  def show
  end

  # GET /admin/furniture/wood/colors/new
  def new
    @admin_furniture_wood_color = Admin::Furniture::Wood::Color.new
  end

  # GET /admin/furniture/wood/colors/1/edit
  def edit
  end

  # POST /admin/furniture/wood/colors
  # POST /admin/furniture/wood/colors.json
  def create
    @admin_furniture_wood_color = Admin::Furniture::Wood::Color.new(admin_furniture_wood_color_params)

    respond_to do |format|
      if @admin_furniture_wood_color.save
        format.html { redirect_to admin_furniture_wood_colors_path, notice: mk_notice(@admin_furniture_wood_color, :name, 'رنگ چوب', :create) }
        format.json { render json: @admin_furniture_wood_color, status: :created, location: admin_furniture_wood_colors_path }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_wood_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture/wood/colors/1
  # PATCH/PUT /admin/furniture/wood/colors/1.json
  def update
    respond_to do |format|
      if @admin_furniture_wood_color.update(admin_furniture_wood_color_params)
        format.html { redirect_to admin_furniture_wood_colors_path, notice: mk_notice(@admin_furniture_wood_color, :name, 'رنگ چوب', :update) }
        format.json { render json: @admin_furniture_wood_color, status: :ok, location: admin_furniture_wood_colors_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_wood_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture/wood/colors/1
  # DELETE /admin/furniture/wood/colors/1.json
  def destroy
    @admin_furniture_wood_color.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_wood_colors_path, notice: mk_notice(@admin_furniture_wood_color, :name, 'رنگ چوب', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_wood_color
      @admin_furniture_wood_color = Admin::Furniture::Wood::Color.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_wood_color_params
      params.require(:admin_furniture_wood_color).permit(:name, :value, :comment)
    end
end
