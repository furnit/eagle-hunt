class FurnitureTypesController < ApplicationController
  before_action :set_furniture_type, only: [:show, :edit, :update, :destroy, :delete_image]
  before_action :fetch_uploaded_images, only: [:update, :created]

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
        format.html { redirect_to @furniture_type, notice: 'دسته‌بندی جدید «</b>%s<b>» با موفقیت ایجاد شد.' %@furniture_type.name }
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
    @furniture_type.destroy
    respond_to do |format|
      format.html { redirect_to furniture_types_url, notice: 'دسته‌بندی «</b>%s<b>» با موفقیت حذف شد.' %@furniture_type.name }
      format.json { head :no_content }
    end
  end
  
  # DELETE /furniture_types/1/delete_image?i=1
  def delete_image
    remain_images = @furniture_type.images
    deleted_image = remain_images.delete_at(params.permit(:i)[:i].to_i)
    deleted_image.remove!
    @furniture_type.images = remain_images  
    respond_to do |format|
      if @furniture_type.save
        format.html { redirect_to @furniture_type, notice: 'عکس دسته‌بندی با موفقیت حذف گردید.' %@furniture_type.name }
        format.json { render json: { obj: deleted_image.url, order: @furniture_type.images.each.with_index.map {|i, index| {target: i.thumb.url, url: delete_image_furniture_type_path(@furniture_type, :format => :json, :i => index)} }}, status: :created, location: @furniture_type }
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
    end

    def fetch_uploaded_images 
      return unless params[:furniture_type][:imid]
      uploaded_files = UploadedFile.find(params[:furniture_type][:imid]);
      images = uploaded_files.map { |m| m.images }
      @furniture_type.images = [];
      images.each do |i|
        @furniture_type.images += i;
      end
      @furniture_type.images.each { |i| i.recreate_versions! }
      uploaded_files.each { |u| u.destroy }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def furniture_type_params
      params.require(:furniture_type).permit(:name, :comment, {images: []})
    end
end
