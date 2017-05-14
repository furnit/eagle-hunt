class Admin::Pricing::KalafsController < Admin::AdminbaseController
  before_action :set_admin_pricing_kalaf, only: [:show, :edit, :update, :destroy]

  # GET /admin/pricing/kalafs
  # GET /admin/pricing/kalafs.json
  def index
    @admin_pricing_kalafs = [Admin::Pricing::Kalaf.last] - [nil]

    respond_to do |format|
      format.html
      format.json { render json: @admin_pricing_kalafs.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/pricing/kalafs/1
  # GET /admin/pricing/kalafs/1.json
  def show
  end

  # GET /admin/pricing/kalafs/new
  def new
    @admin_pricing_kalaf = Admin::Pricing::Kalaf.new
  end

  # GET /admin/pricing/kalafs/1/edit
  def edit
  end

  # POST /admin/pricing/kalafs
  # POST /admin/pricing/kalafs.json
  def create
    @admin_pricing_kalaf = Admin::Pricing::Kalaf.new(admin_pricing_kalaf_params)

    respond_to do |format|
      if @admin_pricing_kalaf.save
        format.html { redirect_to admin_pricing_kalafs_path, notice: mk_notice(@admin_pricing_kalaf, :id, 'Kalaf', :create) }
        format.json { render json: @admin_pricing_kalaf, status: :created, location: admin_pricing_kalafs_path }
      else
        format.html { render :new }
        format.json { render json: @admin_pricing_kalaf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pricing/kalafs/1
  # PATCH/PUT /admin/pricing/kalafs/1.json
  def update
    respond_to do |format|
      if @admin_pricing_kalaf.update(admin_pricing_kalaf_params)
        format.html { redirect_to admin_pricing_kalafs_path, notice: mk_notice(@admin_pricing_kalaf, :id, 'Kalaf', :update) }
        format.json { render json: @admin_pricing_kalaf, status: :ok, location: admin_pricing_kalafs_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_pricing_kalaf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pricing/kalafs/1
  # DELETE /admin/pricing/kalafs/1.json
  def destroy
    @admin_pricing_kalaf.destroy
    respond_to do |format|
      format.html { redirect_to admin_pricing_kalafs_path, notice: mk_notice(@admin_pricing_kalaf, :id, 'Kalaf', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_pricing_kalaf
      @admin_pricing_kalaf = Admin::Pricing::Kalaf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_pricing_kalaf_params
      params.require(:admin_pricing_kalaf).permit(:price, :comment)
    end
end
