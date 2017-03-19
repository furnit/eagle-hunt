class FurnitureTypesController < ApplicationController
  before_action :set_furniture_type, only: [:show, :edit, :update, :destroy, :delete_image, :archive]

  # GET /furniture_types
  # GET /furniture_types.json
  def index
    redirect_to root_path
  end

  # GET /furniture_types/1
  # GET /furniture_types/1.json
  def show
    @furniture = @furniture_type.furniture
  end

  # GET /furniture_types/new
  def new
    @furniture_type = FurnitureType.new
  end

  # GET /furniture_types/1/edit
  def edit
  end

  # POST /furniture_types
  # POST /furniture_types.json
  def create
    @furniture_type = FurnitureType.new(furniture_type_params)

    respond_to do |format|
      if @furniture_type.save
        # update the uploaded image and re-save the model
        # the model need to be created at first then the update happen
        update_uploaded_images && @furniture_type.save
        format.html { redirect_to @furniture_type, notice: 'دسته‌بندی جدید «<b>%s</b>» با موفقیت ایجاد شد.' %@furniture_type.name }
        format.json { render :show, status: :created, location: @furniture_type }
      else
        format.html { render :new }
        format.json { render json: @furniture_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /furniture_types/1
  # PATCH/PUT /furniture_types/1.json
  def update
    # update the uploaded images
    update_uploaded_images
    respond_to do |format|
      if @furniture_type.update(furniture_type_params)
        format.html { redirect_to @furniture_type, notice: 'دسته‌بندی «<b>%s</b>» با موفقیت ویرایش شد.' %@furniture_type.name }
        format.json { render :show, status: :ok, location: @furniture_type }
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
    @furniture_type.destroy!
    # respond to format
    respond_to do |format|
      format.html { redirect_to furniture_types_url, notice: 'دسته‌بندی «<b>%s</b>» با موفقیت حذف شد.' %@furniture_type.name }
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
    undo_url = view_context.link_to view_context.raw('<span class="fa fa-recycle"></span> بازیافت'), recover_furniture_type_path, :method => :patch
    # respond to format
    respond_to do |format|
      format.html { redirect_to furniture_types_url, notice: "دسته‌بندی «<b>#{@furniture_type.name}</b>» با موفقیت آرشیو شد. [ #{undo_url} ] " }
      format.json { head :no_content }
    end
  end
  
  def recover
    # un-archive the furniture type and its related furniture
    FurnitureType.only_deleted.where("id = ?", params[:id]).first.recover
    # fetch the un-archived f-type
    set_furniture_type
    # restore the f of the un-archived type
    @furniture_type.furniture.only_deleted.update_all(['deleted_at = ?', nil]);
    # make an undo link to un-acrhiving
    undo_url = view_context.link_to view_context.raw('<span class="fa fa-archive"></span> آرشیو') , archive_furniture_type_path, :method => :delete
    # respond to format
    respond_to do |format|
      format.html { redirect_to furniture_type_path(:id => params[:id]), notice: "دسته‌بندی «<b>#{@furniture_type.name}</b>» با موفقیت از آرشیو خارج شد. [ #{undo_url} ] " }
      format.json { head :no_content }
    end
  end
  
  # DELETE /furniture_types/1/delete_image?i=1 {i => index of the target image}
  def delete_image
    # list current images
    remain_images = @furniture_type.images
    # delete the target image from the list
    deleted_image = remain_images.delete_at(params.permit(:i)[:i].to_i)
    # remove the actual file from the FS
    deleted_image.remove!
    # the hack for carrier wave bug [issue#2141]
    if remain_images.empty?
      @furniture_type.write_attribute(:images, nil)
    else      
      @furniture_type.images = remain_images  
    end
    # respond to format
    respond_to do |format|
      if @furniture_type.save
        format.html { redirect_to @furniture_type, notice: 'عکس دسته‌بندی با موفقیت حذف گردید.' %@furniture_type.name }
        format.json { render json: { order: @furniture_type.images.each.with_index.map {|i, index| {target: i.thumb.url, url: delete_image_furniture_type_path(@furniture_type, :format => :json, :i => index)} }}, status: :created, location: @furniture_type }
      else
        format.html { render :new }
        format.json { render json: @furniture_type.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_furniture_type
      @furniture_type = FurnitureType.find(params[:id])
      # if image list is nill? make it an empty array
      @furniture_type.images ||= []
    end

    def update_uploaded_images
      # return if no image uploaded 
      return unless params[:furniture_type][:imid]
      # find the uploaded imaged with passed image ids
      uploaded_files = UploadedFile.find(params[:furniture_type][:imid]);
      # list uploaded images and append the to current image list 
      uploaded_files.each { |m| @furniture_type.images += m.images }
      # re-create versions of all images  
      @furniture_type.images.each { |i| i.recreate_versions! }
      # destroy the temp uploaded images
      uploaded_files.each { |u| u.destroy }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def furniture_type_params
      params.require(:furniture_type).permit(:name, :comment)
    end
end
