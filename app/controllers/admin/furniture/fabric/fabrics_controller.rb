class Admin::Furniture::Fabric::FabricsController < Admin::UploaderController
  before_action :set_admin_furniture_fabric, only: [:show, :edit, :update, :archive]

  # GET /admin/fabrics
  # GET /admin/fabrics.json
  def index
    @admin_furniture_fabrics = Admin::Furniture::Fabric::Fabric.with_deleted.paginate(page: params[:page])
  end

  # GET /admin/fabrics/1
  # GET /admin/fabrics/1.json
  def show
  end

  # GET /admin/fabrics/new
  def new
    @admin_furniture_fabric = Admin::Furniture::Fabric::Fabric.new
    consider_parital_view
  end

  # GET /admin/fabrics/1/edit
  def edit
    consider_parital_view
  end

  # POST /admin/fabrics
  # POST /admin/fabrics.json
  def create
    @admin_furniture_fabric = Admin::Furniture::Fabric::Fabric.new(admin_furniture_fabric_params)

    respond_to do |format|
      if @admin_furniture_fabric.save
        # update the uploaded image and re-save the model
        # the model need to be created at first then the update happen
        update_uploaded_images @admin_furniture_fabric, :admin_furniture_fabric_fabric, auto_save: true
        format.html { redirect_to admin_furniture_fabric_fabrics_path, notice: "طرح «<b>#{@admin_furniture_fabric.id}</b>» با موفقیت ایجاد شد." }
        format.json { render json: @admin_furniture_fabric, status: :created, location: params[:noredir].nil? ? admin_furniture_fabric_fabrics_path : nil }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_fabric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/fabrics/1
  # PATCH/PUT /admin/fabrics/1.json
  def update
    prevent_browser_caching
    # update the uploaded images
    update_uploaded_images @admin_furniture_fabric, :admin_furniture_fabric_fabric
    respond_to do |format|
      if @admin_furniture_fabric.update(admin_furniture_fabric_params)
        format.html { redirect_to admin_furniture_fabric_fabrics_path, notice: "طرح «<b>#{@admin_furniture_fabric.id}</b>» با موفقیت ویرایش شد." }
        format.json { render json: @admin_furniture_fabric, status: :ok, location: params[:noredir].nil? ? admin_furniture_fabric_fabrics_path : nil }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_fabric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/fabrics/1
  # DELETE /admin/fabrics/1.json
  def destroy
    @admin_furniture_fabric = Admin::Furniture::Fabric::Fabric.with_deleted.find(params[:id])
    # remove the images
    @admin_furniture_fabric.remove_images!
    # delete the record
    @admin_furniture_fabric.destroy_fully!
    respond_to do |format|
      format.html { redirect_to admin_furniture_fabric_fabrics_path, notice: "طرح «<b>#{@admin_furniture_fabric.id}</b>» با موفقیت حذف شد." }
      format.json { head :no_content }
    end
  end
  
  def archive
    # archive current type
    @admin_furniture_fabric.destroy
    # make an undo link to un-acrhiving
    undo_url = view_context.link_to view_context.raw('<span class="fa fa-recycle"></span> بازیافت'), recover_admin_furniture_fabric_fabric_path, :method => :patch
    # respond to format
    respond_to do |format|
      format.html { redirect_to admin_furniture_fabric_fabrics_path, notice: "طرح «<b>#{@admin_furniture_fabric.id}</b>» با موفقیت آرشیو شد. [ #{undo_url} ] " }
      format.json { head :no_content }
    end
  end
  
  def recover no_redirect: false
    # un-archive the fabric type
    @admin_furniture_fabric = Admin::Furniture::Fabric::Fabric.only_deleted.where("id = ?", params[:id]).first
    @admin_furniture_fabric.recover
    # make an undo link to un-acrhiving
    undo_url = view_context.link_to view_context.raw('<span class="fa fa-archive"></span> آرشیو') , archive_admin_furniture_fabric_fabric_path, :method => :delete
    # return if this is an internal call
    return if no_redirect
    # respond to format
    respond_to do |format|
      format.html { redirect_to admin_furniture_fabric_fabrics_path, notice: "طرح «<b>##{@admin_furniture_fabric.id}</b>» با موفقیت از آرشیو خارج شد. [ #{undo_url} ] " }
      format.json { head :no_content }
    end
  end

  def list_images
    ls_images Admin::Furniture::Fabric::Fabric.with_deleted.find(params[:id])
  end

  private
  
    def consider_parital_view
      return if not params[:pv]
      id = params[:pv].to_i
      partials = [
        '01_general',
        '02_images_detail'
      ]
      if partials[id]
        render partial: "admin/furniture/fabric/fabrics/forms/#{partials[id]}"
      end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_fabric
      @admin_furniture_fabric = Admin::Furniture::Fabric::Fabric.find(params[:id])
      @admin_furniture_fabric.images_detail ||= []
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_fabric_params
      params.require(:admin_furniture_fabric_fabric).permit(:admin_furniture_fabric_type_id, :admin_furniture_fabric_brand_id, :comment, { images_detail: [] })
    end
end
