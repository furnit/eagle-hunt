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
        upload_models
        format.html { redirect_to admin_furniture_fabric_fabrics_path, notice: mk_notice(@admin_furniture_fabric, :id, 'طرح', :create) }
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
    # upload the models
    upload_models
    
    respond_to do |format|
      if @admin_furniture_fabric.update(admin_furniture_fabric_params)
        
        if not admin_furniture_fabric_models_name.empty?
          @admin_furniture_fabric.models.each do |model|
            raise RuntimeError.new("invalid data for registered model!") if not admin_furniture_fabric_models_name[model.id.to_s]
            model.name = admin_furniture_fabric_models_name[model.id.to_s]
            model.save
          end
        end
        
        format.html { redirect_to admin_furniture_fabric_fabrics_path, notice: mk_notice(@admin_furniture_fabric, :id, 'طرح', :update) }
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
    # delete the record
    @admin_furniture_fabric.destroy_fully!
    respond_to do |format|
      format.html { redirect_to admin_furniture_fabric_fabrics_path, notice: mk_notice(@admin_furniture_fabric, :id, 'طرح', :destroy) }
      format.json { head :no_content }
    end
  end
  
  def archive
    # archive current type, DON'T `destroy` it, because of the `models` dependancy, will also be destroyed for real
    @admin_furniture_fabric.update(deleted_at: Time.now)
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
    ls_images nil, images: Admin::Furniture::Fabric::Fabric.with_deleted.find(params[:id]).models.map { |m| m.images }.flatten
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
  
    def upload_models  
      # upload new images
      (admin_furniture_fabric_image_ids[:imid] || []).each do |imid|
        m = Admin::Furniture::Fabric::Model.new
        m.fabric = @admin_furniture_fabric
        m.image = imid
        m.save!
      end
      # remove target images
      if admin_furniture_fabric_image_ids[:images_to_delete]
        Admin::Furniture::Fabric::Model.select_by_images(admin_furniture_fabric_image_ids[:images_to_delete]).destroy_all
      end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_fabric
      @admin_furniture_fabric = Admin::Furniture::Fabric::Fabric.find(params[:id])
      @admin_furniture_fabric.images_detail ||= []
    end

    def admin_furniture_fabric_models_name
      params.fetch(:admin_furniture_fabric_model, { })[:name] || { }
    end

    def admin_furniture_fabric_image_ids
      params.require(:admin_furniture_fabric_fabric).permit({imid: []}, {images_to_delete: []})
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_fabric_params
      params.require(:admin_furniture_fabric_fabric).permit(:admin_furniture_fabric_type_id, :admin_furniture_fabric_brand_id, :comment)
    end
end
