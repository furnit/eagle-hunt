class Admin::UserTypesController < Admin::AdminbaseController
  before_action :set_admin_user_type, only: [:show, :edit, :update, :destroy]

  # GET /admin/user_types
  # GET /admin/user_types.json
  def index
    @admin_user_types = Admin::UserType.all
  end

  # GET /admin/user_types/1
  # GET /admin/user_types/1.json
  def show
  end

  # GET /admin/user_types/new
  def new
    @admin_user_type = Admin::UserType.new
  end

  # GET /admin/user_types/1/edit
  def edit
  end

  # POST /admin/user_types
  # POST /admin/user_types.json
  def create
    @admin_user_type = Admin::UserType.new(admin_user_type_params)

    respond_to do |format|
      if @admin_user_type.save
        format.html { redirect_to admin_user_types_path, notice: 'نوع کاربر «<b>%s</b>» با موفقیت ایجاد شد.' %@admin_user_type.name }
        format.json { render :index, status: :created, location: admin_user_types_path }
      else
        format.html { render :new }
        format.json { render json: @admin_user_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/user_types/1
  # PATCH/PUT /admin/user_types/1.json
  def update
    respond_to do |format|
      if @admin_user_type.update(admin_user_type_params)
        format.html { redirect_to admin_user_types_path, notice: 'نوع کاربر «<b>%s</b>» با موفقیت ویرایش شد.' %@admin_user_type.name  }
        format.json { render :show, status: :ok, location: @admin_user_type }
      else
        format.html { render :edit }
        format.json { render json: @admin_user_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/user_types/1
  # DELETE /admin/user_types/1.json
  def destroy
    @admin_user_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_user_types_url, notice: 'نوع کاربر «<b>%s</b>» با موفقیت حذف شد.' %@admin_user_type.name  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user_type
      @admin_user_type = Admin::UserType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_type_params
      params.require(:admin_user_type).permit(:name, :comment, :auth_level)
    end
end
