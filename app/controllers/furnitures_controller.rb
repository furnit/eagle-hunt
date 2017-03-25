class FurnituresController < UploaderController
  before_action :set_furniture, only: [:show, :edit, :update, :destroy, :delete_image, :cover, :edit_description, :update_description]

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
        # make_cover no_respond: true
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
    prevent_browser_caching
    # update the uploaded images
    update_uploaded_images @furniture, :furniture
    # if the user removed the cover image? reset the cover index 
    @furniture.cover_details[:index] = 0 if ((params[:furniture][:images_to_delete] and params[:furniture][:images_to_delete].include? @furniture.cover_details['index']) or @furniture.cover_details['index'].to_i >= @furniture.images.length)
    
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
  
  # POST /furniture/1/edit_cover.json
  def cover
    
    details = params.require(:furniture).permit(:cover, :index);
    
    @furniture.cover_details['pos'] =  details[:cover] || @furniture.cover_details['pos']
    @furniture.cover_details['index'] =  details[:index] || @furniture.cover_details['index']
    
    respond_to do |format|      
      if @furniture.save
        format.json { render json: {}, status: :ok, location: @furniture }
      else
        format.json { render json: @furniture.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_description
  end
  
  def update_description
    raise 'invalid input' if not furniture_params[:description]
    respond_to do |format|
      if @furniture.update({:description => furniture_params[:description], :description_html => GitHub::Markup.render_s(GitHub::Markups::MARKUP_MARKDOWN, furniture_params[:description])})
        format.html { redirect_to @furniture, notice: 'محصول «<b>%s</b>» با موفقیت ویرایش شد.' %@furniture.name }
        format.json { render json: @furniture, status: :ok, location: @furniture }
      else
        format.html { redirect_to @furniture, error: 'خطا در ویرایش محصول «<b>%s</b>»!' %@furniture.name }
        format.json { render json: @furniture.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def markup
    require 'github/markup'
    
    text = params.permit(:text)[:text] || ''
    
    respond_to do |format|  
      format.json { render json: { html: GitHub::Markup.render_s(GitHub::Markups::MARKUP_MARKDOWN, text) }, status: :ok }
    end
  end

  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_furniture
      @furniture = Furniture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def furniture_params
      params.require(:furniture).permit(:id, :name, :comment, :furniture_type_id, :description)
    end
end
