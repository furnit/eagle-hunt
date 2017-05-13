class Admin::Pricing::KanafsController < Admin::AdminbaseController
  before_action :set_admin_pricing_kanaf, only: [:show, :edit, :update, :destroy]

  # GET /admin/pricing/kanafs
  # GET /admin/pricing/kanafs.json
  def index
    @admin_pricing_kanafs = [Admin::Pricing::Kanaf.last] - [nil]

    respond_to do |format|
      format.html
      format.json { render json: @admin_pricing_kanafs.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/pricing/kanafs/1
  # GET /admin/pricing/kanafs/1.json
  def show
  end

  # GET /admin/pricing/kanafs/new
  def new
    @admin_pricing_kanaf = Admin::Pricing::Kanaf.new
  end

  # GET /admin/pricing/kanafs/1/edit
  def edit
  end

  # POST /admin/pricing/kanafs
  # POST /admin/pricing/kanafs.json
  def create
    @admin_pricing_kanaf = Admin::Pricing::Kanaf.new(admin_pricing_kanaf_params)

    respond_to do |format|
      if @admin_pricing_kanaf.save
        format.html { redirect_to admin_pricing_kanafs_path, notice: mk_notice(@admin_pricing_kanaf, :id, 'Kanaf', :create) }
        format.json { render json: @admin_pricing_kanaf, status: :created, location: admin_pricing_kanafs_path }
      else
        format.html { render :new }
        format.json { render json: @admin_pricing_kanaf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pricing/kanafs/1
  # PATCH/PUT /admin/pricing/kanafs/1.json
  def update
    respond_to do |format|
      if @admin_pricing_kanaf.update(admin_pricing_kanaf_params)
        format.html { redirect_to admin_pricing_kanafs_path, notice: mk_notice(@admin_pricing_kanaf, :id, 'Kanaf', :update) }
        format.json { render json: @admin_pricing_kanaf, status: :ok, location: admin_pricing_kanafs_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_pricing_kanaf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pricing/kanafs/1
  # DELETE /admin/pricing/kanafs/1.json
  def destroy
    @admin_pricing_kanaf.destroy
    respond_to do |format|
      format.html { redirect_to admin_pricing_kanafs_path, notice: mk_notice(@admin_pricing_kanaf, :id, 'Kanaf', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_pricing_kanaf
      @admin_pricing_kanaf = Admin::Pricing::Kanaf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_pricing_kanaf_params
      params.require(:admin_pricing_kanaf).permit(:price, :comment)
    end
end
