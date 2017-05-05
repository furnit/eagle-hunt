class Admin::FurnitureSectionsController < Admin::UploaderController
  before_action :set_admin_furniture_section, only: [:show, :edit, :update, :destroy, :list_images]

  # GET /admin/furniture_sections
  # GET /admin/furniture_sections.json
  def index
    @admin_furniture_sections = Admin::FurnitureSection.all
  end

  # GET /admin/furniture_sections/new
  def new
    @admin_furniture_section = Admin::FurnitureSection.new
  end

  # GET /admin/furniture_sections/1/edit
  def edit
  end

  # POST /admin/furniture_sections
  # POST /admin/furniture_sections.json
  def create
    @admin_furniture_section = Admin::FurnitureSection.new(admin_furniture_section_params)

    respond_to do |format|
      if @admin_furniture_section.save
        update_uploaded_images @admin_furniture_section, :admin_furniture_section, auto_save: true
        format.html { redirect_to admin_furniture_sections_path, notice: "قسمت «<b>#{@admin_furniture_section.name}</b>» با موفقیت ایجاد شد." }
        format.json { render json: @admin_furniture_section, status: :created, location: @admin_furniture_section }
      else
        format.html { render json: @admin_furniture_section }
        format.json { render json: @admin_furniture_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture_sections/1
  # PATCH/PUT /admin/furniture_sections/1.json
  def update
    prevent_browser_caching
    # update the uploaded images
    update_uploaded_images @admin_furniture_section, :admin_furniture_section
    respond_to do |format|
      if @admin_furniture_section.update(admin_furniture_section_params)
        format.html { redirect_to admin_furniture_sections_path, notice: "قسمت «<b>#{@admin_furniture_section.name}</b>» با موفقیت ویرایش شد." }
        format.json { render json: @admin_furniture_section, status: :ok, location: @admin_furniture_section }
      else
        format.html { render json: @admin_furniture_section }
        format.json { render json: @admin_furniture_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture_sections/1
  # DELETE /admin/furniture_sections/1.json
  def destroy
    # @admin_furniture_section.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_sections_url, notice: "قسمت «<b>#{@admin_furniture_section.name}</b>» با موفقیت حذف شد."}
      format.json { head :no_content }
    end
  end

  def list_images
    ls_images @admin_furniture_section
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_section
      @admin_furniture_section = Admin::FurnitureSection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_section_params
      # ignore the name change
      params.require(:admin_furniture_section).permit(:comment)
    end
end
