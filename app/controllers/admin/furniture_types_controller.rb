class Admin::FurnitureTypesController < Admin::UploaderController
  before_action :set_furniture_type, only: [:show, :edit, :update, :destroy, :delete_image, :archive]

  # GET /furniture_types
  # GET /furniture_types.json
  def index
    @furniture_types = Admin::FurnitureType.all.with_deleted.paginate(:page => params[:page])

    respond_to do |format|
      format.html 
      format.json { render json: @furniture_types, status: :ok }
    end
  end

  # GET /furniture_types/1
  # GET /furniture_types/1.json
  def show
    @furniture = @furniture_type.furniture
  end

  # GET /furniture_types/new
  def new
    @furniture_type = Admin::FurnitureType.new
  end

  # GET /furniture_types/1/edit
  def edit
  end

  # POST /furniture_types
  # POST /furniture_types.json
  def create
    @furniture_type = Admin::FurnitureType.new(furniture_type_params)

    respond_to do |format|
      if @furniture_type.save
        # update the uploaded image and re-save the model
        # the model need to be created at first then the update happen
        update_uploaded_images @furniture_type, :furniture_type , auto_save: true
        format.html { redirect_to admin_furniture_types_path, notice: 'دسته‌بندی جدید «<b>%s</b>» با موفقیت ایجاد شد.' %@furniture_type.name }
        format.json { render json: @furniture_type, status: :created, location: @furniture_type }
      else
        format.html { render :new }
        format.json { render json: @furniture_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /furniture_types/1
  # PATCH/PUT /furniture_types/1.json
  def update
    prevent_browser_caching
    # update the uploaded images
    update_uploaded_images @furniture_type, :furniture_type
    respond_to do |format|
      if @furniture_type.update(furniture_type_params)
        format.html { redirect_to home_category_path(@furniture_type), notice: 'دسته‌بندی «<b>%s</b>» با موفقیت ویرایش شد.' %@furniture_type.name }
        format.json { render json: @furniture_type, status: :ok, location: @furniture_type }
      else
        format.html { render :edit }
        format.json { render json: @furniture_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /furniture_types/1
  # DELETE /furniture_types/1.json
  def destroy
    # remove the images of f's that are about to delete
    @furniture_type.furniture.each(&:remove_images!)
    # delete the f's records
    @furniture_type.furniture.delete_all!
    # remove the f.type's images
    @furniture_type.remove_images!
    # delete the f.type's record
    @furniture_type.destroy_fully!
    # respond to format
    respond_to do |format|
      format.html { redirect_to admin_furniture_types_path, notice: 'دسته‌بندی «<b>%s</b>» با موفقیت حذف شد.' %@furniture_type.name }
      format.json { head :no_content }
    end
  end
  
  # DELETE /furniture_types/1
  # DELETE /furniture_types/1.json
  def archive
    # archive current type
    @furniture_type.destroy
    # recursivly archive the furnitures
    @furniture_type.furniture.destroy_all
    # make an undo link to un-acrhiving
    undo_url = view_context.link_to view_context.raw('<span class="fa fa-recycle"></span> بازیافت'), recover_admin_furniture_type_path, :method => :patch
    # respond to format
    respond_to do |format|
      format.html { redirect_to admin_furniture_types_path, notice: "دسته‌بندی «<b>#{@furniture_type.name}</b>» با موفقیت آرشیو شد. [ #{undo_url} ] " }
      format.json { head :no_content }
    end
  end
  
  def recover
    # un-archive the furniture type and its related furniture
    Admin::FurnitureType.only_deleted.where("id = ?", params[:id]).first.recover
    # fetch the un-archived f-type
    set_furniture_type
    # restore the f of the un-archived type
    @furniture_type.furniture.only_deleted.update_all(['deleted_at = ?', nil]);
    # make an undo link to un-acrhiving
    undo_url = view_context.link_to view_context.raw('<span class="fa fa-archive"></span> آرشیو') , archive_admin_furniture_type_path, :method => :delete
    # respond to format
    respond_to do |format|
      format.html { redirect_to admin_furniture_types_path, notice: "دسته‌بندی «<b>#{@furniture_type.name}</b>» با موفقیت از آرشیو خارج شد. [ #{undo_url} ] " }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_furniture_type
      @furniture_type = Admin::FurnitureType.find(params[:id])
      # if image list is nill? make it an empty array
      @furniture_type.images ||= []
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def furniture_type_params
      params.require(:admin_furniture_type).permit(:name, :comment)
    end
end
