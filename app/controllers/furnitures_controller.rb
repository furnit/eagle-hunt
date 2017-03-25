class FurnituresController < UploaderController
  before_action :set_furniture, only: [:show, :edit, :update, :destroy, :delete_image, :make_cover, :edit_cover]

  # GET /furnitures
  # GET /furnitures.json
  def index
    @furnitures = Furniture.all
  end

  # GET /furnitures/1
  # GET /furnitures/1.json
  def show
    if user_signed_in?
      @shopping = ShoppingCart.select('id').where('user_id = ? AND furniture_id = ?', current_user.id, @furniture.id).first
      @shopping = @shopping.id unless not @shopping
    else
      @shopping = ((session[:shopping_cart] and session[:shopping_cart].include? @furniture.id.to_s) ? 0 : nil)
    end
  end

  # GET /furnitures/new
  def new
    @furniture = Furniture.new
    @furniture.furniture_type_id = params[:cat].to_i if params[:cat]
  end

  # GET /furnitures/1/edit
  def edit
  end

  # POST /furnitures
  # POST /furnitures.json
  def create
    @furniture = Furniture.new(furniture_params)
    respond_to do |format|
      if @furniture.save
        # update the uploaded image and re-save the model
        # the model need to be created at first then the update happen
        update_uploaded_images @furniture, :furniture , auto_save: true
        params[:furniture] = { iid: 0 }.with_indifferent_access.merge(params[:furniture]);
        @furniture.reload;
        make_cover no_respond: true
        format.html { redirect_to @furniture, notice: 'دسته‌بندی جدید «<b>%s</b>» با موفقیت ایجاد شد.' %@furniture.name }
        format.json { render json: @furniture, status: :created, location: @furniture }
      else
        format.html { render :new }
        format.json { render json: @furniture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /furnitures/1
  # PATCH/PUT /furnitures/1.json
  def update
    # update the uploaded images
    update_uploaded_images @furniture, :furniture
    params[:furniture] = { iid: 0 }.with_indifferent_access.merge(params[:furniture]);
    @furniture.reload;
    make_cover no_respond: true
    respond_to do |format|
      if @furniture.update(furniture_params)
        format.html { redirect_to @furniture, notice: 'محصول «<b>%s</b>» با موفقیت ویرایش شد.' %@furniture.name }
        format.json { render json: @furniture, status: :ok, location: @furniture }
      else
        format.html { render :edit }
        format.json { render json: @furniture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /furnitures/1
  # DELETE /furnitures/1.json
  def destroy
    @furniture.destroy
    respond_to do |format|
      format.html { redirect_to furniture_type_url(:id => @furniture.furniture_type_id), notice: 'محصول «<b>%s</b>» با موفقیت حذف شد.' %@furniture.name }
      format.json { head :no_content }
    end
  end
  
  # DELETE /furniture/1/delete_image?i=1 {i => index of the target image}
  def delete_image
    delete_instance_image @furniture
    
    # respond to format
    respond_to do |format|
      if @furniture.save
        format.html { redirect_to instance, notice: 'عکس محصول «<b>%s</b>» با موفقیت حذف گردید.' %@furniture.name }
        format.json { render json: { order: @furniture.images.each.with_index.map {|i, index| {target: i.thumb.url, url: send("delete_image_#{@furniture.class.name.underscore}_path", @furniture, :format => :json, :i => index)} }}, status: :created, location: @furniture}
      else
        format.html { render :new }
        format.json { render json: @furniture.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /furniture/1/make_cover.json
  def make_cover no_respond: false
    _params = params.require(:furniture).permit(:iid)
    create_cover = ->() {
      return false if not (@furniture.images.length > _params[:iid])
      @furniture.image_profile_id = _params[:iid]
      @furniture.image_profile = @furniture.images[_params[:iid]]
      @furniture.save()
      params[:furniture] = {
        cover: {
          configs: {
            pos: '25%'
          }
        }
      }.with_indifferent_access.merge(params[:furniture])
      edit_cover no_respond: no_respond
      return true
    }
    if no_respond
      create_cover.call();
    else
      respond_to do |format|
        if not create_cover.call()
          format.json { render json: {error: 'Invalid Cover ID!'}, status: :unprocessable_entity }
        end
      end
    end
  end
  
  def edit_cover no_respond: false
    
    prevent_browser_caching
    
    crop_cover = ->() {
      require 'rmagick'
      _params = params[:furniture][:cover] || raise("invalid arg")
      if not @furniture.image_profile.file
        params[:furniture] = { iid: 0 }.with_indifferent_access.merge(params[:furniture])
        make_cover 
      end
      configs = if _params[:configs].is_a? String; JSON.parse(_params[:configs] || raise('invalid arg')) else _params[:configs] end
      crop_percent = (configs['pos'] || raise("invalid arg")).to_f / 100 
      cover_origin_file = @furniture.images[@furniture.image_profile_id].file.file;
      cover = Magick::Image.read(cover_origin_file).first;
      a = [(crop_percent * 100).to_i, (cover.rows - AppConfig.css.furniture.cover.height).abs].min
      k = [0, a, cover.columns, AppConfig.css.furniture.cover.height]
      cover.crop(*k).write(@furniture.image_profile.file.file)
      @furniture.save()
    }
    if no_respond
      crop_cover.call()
    else
      respond_to do |format|
        begin
          crop_cover.call();
          format.json { redirect_to @furniture }
        rescue RuntimeError => e
          format.json { render json: {error: e.message}, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_furniture
      @furniture = Furniture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def furniture_params
      params.require(:furniture).permit(:id, :name, :comment, :furniture_type_id)
    end
end
