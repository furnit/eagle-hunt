class Admin::FabricSectionsController < Admin::UploaderController
  before_action :set_admin_fabric_section, only: [:show, :edit, :update, :destroy]

  # GET /admin/fabric_sections
  # GET /admin/fabric_sections.json
  def index
    @admin_fabric_sections = Admin::FabricSection.all
  end

  # GET /admin/fabric_sections/1
  # GET /admin/fabric_sections/1.json
  def show
  end

  # GET /admin/fabric_sections/new
  def new
    @admin_fabric_section = Admin::FabricSection.new
  end

  # GET /admin/fabric_sections/1/edit
  def edit
  end

  # POST /admin/fabric_sections
  # POST /admin/fabric_sections.json
  def create
    @admin_fabric_section = Admin::FabricSection.new(admin_fabric_section_params)

    respond_to do |format|
      if @admin_fabric_section.save
        update_uploaded_images @admin_fabric_section, :admin_fabric_section, auto_save: true
        format.html { redirect_to admin_fabric_sections_path, notice: "قسمت «<b>#{@admin_fabric_section.name}</b>» با موفقیت ایجاد شد." }
        format.json { render json: @admin_fabric_section, status: :created, location: @admin_fabric_section }
      else
        format.html { render json: @admin_fabric_section }
        format.json { render json: @admin_fabric_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/fabric_sections/1
  # PATCH/PUT /admin/fabric_sections/1.json
  def update
    respond_to do |format|
      if @admin_fabric_section.update(admin_fabric_section_params)
        format.html { redirect_to admin_fabric_sections_path, notice: "قسمت «<b>#{@admin_fabric_section.name}</b>» با موفقیت ویرایش شد." }
        format.json { render json: @admin_fabric_section, status: :ok, location: @admin_fabric_section }
      else
        format.html { render json: @admin_fabric_section }
        format.json { render json: @admin_fabric_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/fabric_sections/1
  # DELETE /admin/fabric_sections/1.json
  def destroy
    @admin_fabric_section.destroy
    respond_to do |format|
      format.html { redirect_to admin_fabric_sections_url, notice: "قسمت «<b>#{@admin_fabric_section.name}</b>» با موفقیت حذف شد."}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_fabric_section
      @admin_fabric_section = Admin::FabricSection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_fabric_section_params
      params.require(:admin_fabric_section).permit(:name, :comment)
    end
end
