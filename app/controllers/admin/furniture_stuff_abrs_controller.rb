class Admin::FurnitureStuffAbrsController < Admin::AdminbaseController
  before_action :set_admin_furniture_stuff_abr, only: [:show, :edit, :update, :destroy]

  # GET /admin/furniture_stuff_abrs
  # GET /admin/furniture_stuff_abrs.json
  def index
    @admin_furniture_stuff_abrs = Admin::FurnitureStuffAbr.all
  end

  # GET /admin/furniture_stuff_abrs/new
  def new
    @admin_furniture_stuff_abr = Admin::FurnitureStuffAbr.new
  end

  # GET /admin/furniture_stuff_abrs/1/edit
  def edit
  end

  # POST /admin/furniture_stuff_abrs
  # POST /admin/furniture_stuff_abrs.json
  def create
    @admin_furniture_stuff_abr = Admin::FurnitureStuffAbr.new(admin_furniture_stuff_abr_params)

    respond_to do |format|
      if @admin_furniture_stuff_abr.save
        format.html { redirect_to admin_furniture_stuff_abrs_path, notice: "ابر «<b>#{@admin_furniture_stuff_abr.name}</b>» با موفقیت ایجاد شد."  }
        format.json { render json: @admin_furniture_stuff_abr, status: :created, location: @admin_furniture_stuff_abr }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_stuff_abr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture_stuff_abrs/1
  # PATCH/PUT /admin/furniture_stuff_abrs/1.json
  def update
    respond_to do |format|
      if @admin_furniture_stuff_abr.update(admin_furniture_stuff_abr_params)
        format.html { redirect_to admin_furniture_stuff_abrs_path, notice: "ابر «<b>#{@admin_furniture_stuff_abr.name}</b>» با موفقیت ویرایش شد."  }
        format.json { render json: @admin_furniture_stuff_abr, status: :ok, location: @admin_furniture_stuff_abr }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_stuff_abr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture_stuff_abrs/1
  # DELETE /admin/furniture_stuff_abrs/1.json
  def destroy
    @admin_furniture_stuff_abr.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_stuff_abrs_path, notice: "ابر «<b>#{@admin_furniture_stuff_abr.name}</b>» با موفقیت ویرایش شد."  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_stuff_abr
      @admin_furniture_stuff_abr = Admin::FurnitureStuffAbr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_stuff_abr_params
      params.require(:admin_furniture_stuff_abr).permit(:name, :value, :comment)
    end
end
