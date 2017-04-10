class Admin::FurnitureSpecsController < Admin::AdminbaseController
  before_action :set_admin_furniture_spec, only: [:show, :edit, :update, :destroy]

  # GET /admin/furniture_specs
  # GET /admin/furniture_specs.json
  def index
    @admin_furniture_specs = Admin::FurnitureSpec.all
  end

  # GET /admin/furniture_specs/new
  def new
    @admin_furniture_spec = Admin::FurnitureSpec.new
  end

  # GET /admin/furniture_specs/1/edit
  def edit
  end

  # POST /admin/furniture_specs
  # POST /admin/furniture_specs.json
  def create
    @admin_furniture_spec = Admin::FurnitureSpec.new(admin_furniture_spec_params)

    respond_to do |format|
      if @admin_furniture_spec.save
        format.html { redirect_to admin_furniture_specs_path, notice: "جزییات «<b>#{@admin_furniture_spec.name}</b>» با موفقیت ایجاد شد." }
        format.json { render json: @admin_furniture_spec, status: :created, location: @admin_furniture_spec }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_spec.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture_specs/1
  # PATCH/PUT /admin/furniture_specs/1.json
  def update
    respond_to do |format|
      if @admin_furniture_spec.update(admin_furniture_spec_params)
        format.html { redirect_to admin_furniture_specs_path, notice: "جزییات «<b>#{@admin_furniture_spec.name}</b>» با موفقیت ویرایش شد." }
        format.json { render json: @admin_furniture_spec, status: :ok, location: @admin_furniture_spec }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_spec.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture_specs/1
  # DELETE /admin/furniture_specs/1.json
  def destroy
    @admin_furniture_spec.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_specs_path, notice: "جزییات «<b>#{@admin_furniture_spec.name}</b>» با موفقیت حذف شد." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_spec
      @admin_furniture_spec = Admin::FurnitureSpec.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_spec_params
      params.require(:admin_furniture_spec).permit(:name, :comment)
    end
end
