class Admin::Furniture::FurnituresController < Admin::UploaderController
  before_action :set_furniture, only: [:show, :edit, :update, :destroy, :cover, :edit_description, :update_description, :ls_intel, :confirm, :compute_cost, :toggle_available]

  # GET /furnitures
  # GET /furnitures.json
  def index
    @filterrific = initialize_filterrific(Admin::Furniture::Furniture, params[:filterrific]) or return

    @furnitures = @filterrific.find.with_deleted.paginate(:page => params[:page])
    
    respond_to do |format|
      format.html
      format.js { render partial: 'admin/shared/list' }
    end
  # Recover from invalid param sets, e.g., when a filter refers to the
  # database id of a record that doesn’t exist any more.
  # In this case we reset filterrific and discard all filter params.
  rescue ActiveRecord::RecordNotFound => e
    redirect_to(reset_filterrific_url(format: :html)) and return
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
    @furniture = Admin::Furniture::Furniture.new
    @furniture.furniture_type_id = params[:cat].to_i if params[:cat]
  end

  # GET /furnitures/1/edit
  def edit
  end

  # POST /furnitures
  # POST /furnitures.json
  def create
    @furniture = Admin::Furniture::Furniture.new(furniture_params)
    # update the uploaded image and re-save the model
    update_uploaded_images @furniture, :admin_furniture_furniture
    
    respond_to do |format|
      if @furniture.save
        format.html { redirect_to redirection_url, notice: 'دسته‌بندی جدید «<b>%s</b>» با موفقیت ایجاد شد.' %@furniture.name }
        format.json { render json: @furniture, status: :created, location: redirection_url }
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
    update_uploaded_images @furniture, :admin_furniture_furniture
    # if the user removed the cover image? reset the cover index
    @furniture.cover_details[:index] = 0 if ((params[:admin_furniture_furniture][:images_to_delete] and params[:admin_furniture_furniture][:images_to_delete].include? @furniture.cover_details['index']) or @furniture.cover_details['index'].to_i >= @furniture.images.length)

    respond_to do |format|
      if @furniture.update(furniture_params)
        format.html { redirect_to redirection_url, notice: 'محصول «<b>%s</b>» با موفقیت ویرایش شد.' %@furniture.name }
        format.json { render json: @furniture, status: :ok, location: redirection_url }
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
      format.html { redirect_to redirection_url(force_admin: true), notice: 'محصول «<b>%s</b>» با موفقیت حذف شد.' %@furniture.name }
      format.json { head :no_content }
    end
  end

  # POST /furniture/1/edit_cover.json
  def cover

    details = params.require(:admin_furniture_furniture).permit(:cover, :index);

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
    require 'github/markup'

    raise 'invalid input' if not furniture_params[:description]
    respond_to do |format|
      if @furniture.update({:description => furniture_params[:description], :description_html => GitHub::Markup.render_s(GitHub::Markups::MARKUP_MARKDOWN, furniture_params[:description])})
        format.html { redirect_to home_furniture_path(@furniture), notice: 'محصول «<b>%s</b>» با موفقیت ویرایش شد.' %@furniture.name }
        format.json { render json: @furniture, status: :ok, location: @furniture }
      else
        format.html { redirect_to home_furniture_path(@furniture), error: 'خطا در ویرایش محصول «<b>%s</b>»!' %@furniture.name }
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
  
  def list_images
    @furniture = Admin::Furniture::Furniture.with_deleted.find(params[:id])
    ls_images @furniture do |obj|
      obj[:cover] = @furniture.cover_details["index"]
    end
  end

  def ls_intel
    @intel = @furniture.intel
  end
  
  def confirm
    results = []
    ls_intel.each do |_, employees|
      employees.each do |intel|
        intel[:data].confirmed = 1
        results << intel[:data].save
      end
    end
    @furniture.ready_for_pricing = furniture_params[:ready_for_pricing] rescue false
    @furniture.has_unconfirmed_data = false
    results << @furniture.save
    
    respond_to do |format|
      if results.all?
        format.html { redirect_to admin_furniture_furnitures_path, notice: 'محصول اطلاعات «<b>%s</b>» با موفقیت تایید شد.' %@furniture.name }
        format.json { render json: {status: :success, operation: :confirm}, status: :ok }
      else
        format.html { redirect_to admin_furniture_furnitures_path, error: 'خطا در تایید اطلاعات محصول «<b>%s</b>»!' %@furniture.name }
        format.json { render json: {status: :failed, operation: :confirm}, status: :unprocessable_entity }
      end
    end
  end

  def toggle_available
    text = @furniture.available ? "غیرقابل سفارش" : "قابل سفارش"
    respond_to do |format|
      if @furniture.update(available: not(@furniture.available))
        format.html { redirect_to redirection_url, notice: "محصول «<b>%s</b>» با موفقیت «<b>#{text}</b>» شد." %@furniture.name }
        format.json { render json: @furniture, status: :ok, location: redirection_url }
      else
        format.html { render :edit }
        format.json { render json: @furniture.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_furniture
      @furniture = Admin::Furniture::Furniture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def furniture_params
      params.require(:admin_furniture_furniture).permit(:id, :name, :comment, :furniture_type_id, :description, :free_cushions, :ready_for_pricing)
    end
    
    def redirection_url force_admin: false
      if force_admin or [(params[:admin_furniture_furniture] and params[:admin_furniture_furniture][:admin]), params[:admin]].any?
        case ((params[:admin_furniture_furniture] and params[:admin_furniture_furniture][:admin]) || params[:admin]).to_s.to_sym
        when :client
          admin_root_path(anchor: admin_furniture_furnitures_path.gsub('/admin/', ''))
        else
          admin_furniture_furnitures_path
        end
      else
        home_furniture_path @furniture
      end
    end
end
