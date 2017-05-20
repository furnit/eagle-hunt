class Admin::Furniture::Foam::TypesController < Admin::AdminbaseController
  before_action :set_admin_furniture_foam_type, only: [:show, :edit, :update, :destroy]

  # GET /admin/furniture_foam_types
  # GET /admin/furniture_foam_types.json
  def index
    @admin_furniture_foam_types = Admin::Furniture::Foam::Type.all
    
    respond_to do |format|
      format.html
      format.json { render json: @admin_furniture_foam_types.map {|i| {value: i.id, text: i.name}}, status: :ok }
    end
  end

  # GET /admin/furniture_foam_types/new
  def new
    @admin_furniture_foam_type = Admin::Furniture::Foam::Type.new
  end

  # GET /admin/furniture_foam_types/1/edit
  def edit
  end

  # POST /admin/furniture_foam_types
  # POST /admin/furniture_foam_types.json
  def create
    @admin_furniture_foam_type = Admin::Furniture::Foam::Type.new(admin_furniture_foam_type_params)

    respond_to do |format|
      if @admin_furniture_foam_type.save
        format.html { redirect_to admin_furniture_foam_types_path, notice: "ابر «<b>#{@admin_furniture_foam_type.name}</b>» با موفقیت ایجاد شد."  }
        format.json { render json: @admin_furniture_foam_type, status: :created, location: @admin_furniture_foam_type }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_foam_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture_foam_types/1
  # PATCH/PUT /admin/furniture_foam_types/1.json
  def update
    respond_to do |format|
      if @admin_furniture_foam_type.update(admin_furniture_foam_type_params)
        format.html { redirect_to admin_furniture_foam_types_path, notice: "ابر «<b>#{@admin_furniture_foam_type.name}</b>» با موفقیت ویرایش شد."  }
        format.json { render json: @admin_furniture_foam_type, status: :ok, location: @admin_furniture_foam_type }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_foam_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture_foam_types/1
  # DELETE /admin/furniture_foam_types/1.json
  def destroy
    @admin_furniture_foam_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_foam_types_path, notice: "ابر «<b>#{@admin_furniture_foam_type.name}</b>» با موفقیت ویرایش شد."  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_foam_type
      @admin_furniture_foam_type = Admin::Furniture::Foam::Type.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_foam_type_params
      params.require(:admin_furniture_foam_type).permit(:name, :value, :comment)
    end
end
