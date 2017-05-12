class Admin::Pricing::TransitsController < Admin::AdminbaseController
  before_action :set_admin_pricing_transit, only: [:show, :edit, :update, :destroy]

  # GET /admin/pricing/transits
  # GET /admin/pricing/transits.json
  def index
    @admin_workshops = Admin::Workshop::Workshop.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_workshops.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/pricing/transits/1
  # GET /admin/pricing/transits/1.json
  def show
  end

  # GET /admin/pricing/transits/new
  def new
    @admin_pricing_transit = Admin::Pricing::Transit.new
  end

  # GET /admin/pricing/transits/1/edit
  def edit
  end

  # POST /admin/pricing/transits
  # POST /admin/pricing/transits.json
  def create
    @admin_pricing_transit = Admin::Pricing::Transit.new(admin_pricing_transit_params)

    respond_to do |format|
      if @admin_pricing_transit.save
        format.html { redirect_to admin_pricing_transits_path, notice: mk_notice(@admin_pricing_transit, :id, 'Transit', :create) }
        format.json { render json: @admin_pricing_transit, status: :created, location: admin_pricing_transits_path }
      else
        format.html { render :new }
        format.json { render json: @admin_pricing_transit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pricing/transits/1
  # PATCH/PUT /admin/pricing/transits/1.json
  def update
    respond_to do |format|
      if @admin_pricing_transit.update(admin_pricing_transit_params)
        format.html { redirect_to admin_pricing_transits_path, notice: mk_notice(@admin_pricing_transit, :id, 'Transit', :update) }
        format.json { render json: @admin_pricing_transit, status: :ok, location: admin_pricing_transits_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_pricing_transit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pricing/transits/1
  # DELETE /admin/pricing/transits/1.json
  def destroy
    @admin_pricing_transit.destroy
    respond_to do |format|
      format.html { redirect_to admin_pricing_transits_path, notice: mk_notice(@admin_pricing_transit, :id, 'Transit', :destroy) }
      format.json { head :no_content }
    end
  end
  
  def ls_transit
    @workshop = Admin::Workshop::Workshop.find(params[:id]);
    @trans = @workshop.transits
    if @trans.empty?
      State.all.each do |s|
        @trans << Admin::Pricing::Transit.new(admin_workshop_workshop_id: params[:id], state_id: s.id)
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_pricing_transit
      @admin_pricing_transit = Admin::Pricing::Transit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_pricing_transit_params
      params.require(:admin_pricing_transit).permit(:admin_workshop_workshop_id, :state_id, :price)
    end
end
