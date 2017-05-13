class Admin::Pricing::FoamsController < Admin::AdminbaseController
  before_action :set_admin_pricing_foam, only: [:show, :edit, :update, :destroy]

  # GET /admin/pricing/foams
  # GET /admin/pricing/foams.json
  def index
    @admin_pricing_foams = Admin::Pricing::Foam.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_pricing_foams.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/pricing/foams/1
  # GET /admin/pricing/foams/1.json
  def show
  end

  # GET /admin/pricing/foams/new
  def new
    @admin_pricing_foam = Admin::Pricing::Foam.new
  end

  # GET /admin/pricing/foams/1/edit
  def edit
  end

  # POST /admin/pricing/foams
  # POST /admin/pricing/foams.json
  def create
    @admin_pricing_foam = Admin::Pricing::Foam.new(admin_pricing_foam_params)

    respond_to do |format|
      if @admin_pricing_foam.save
        format.html { redirect_to admin_pricing_foams_path, notice: mk_notice(@admin_pricing_foam, @admin_pricing_foam.type.name, 'قیمت ابر', :create) }
        format.json { render json: @admin_pricing_foam, status: :created, location: admin_pricing_foams_path }
      else
        format.html { render :new }
        format.json { render json: @admin_pricing_foam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pricing/foams/1
  # PATCH/PUT /admin/pricing/foams/1.json
  def update
    respond_to do |format|
      if @admin_pricing_foam.update(admin_pricing_foam_params)
        format.html { redirect_to admin_pricing_foams_path, notice: mk_notice(@admin_pricing_foam, @admin_pricing_foam.type.name, 'قیمت ابر', :update) }
        format.json { render json: @admin_pricing_foam, status: :ok, location: admin_pricing_foams_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_pricing_foam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pricing/foams/1
  # DELETE /admin/pricing/foams/1.json
  def destroy
    @admin_pricing_foam.destroy
    respond_to do |format|
      format.html { redirect_to admin_pricing_foams_path, notice: mk_notice(@admin_pricing_foam, @admin_pricing_foam.type.name, 'قیمت ابر', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_pricing_foam
      @admin_pricing_foam = Admin::Pricing::Foam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_pricing_foam_params
      params.require(:admin_pricing_foam).permit(:admin_furniture_foam_type_id, :price, :comment)
    end
end
