class Admin::Pricing::ConstsController < Admin::AdminbaseController
  before_action :set_admin_pricing_const, only: [:show, :edit, :update, :destroy]

  # GET /admin/pricing/consts
  # GET /admin/pricing/consts.json
  def index
    @admin_pricing_consts = Admin::Pricing::Const.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_pricing_consts.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/pricing/consts/1
  # GET /admin/pricing/consts/1.json
  def show
  end

  # GET /admin/pricing/consts/new
  def new
    @admin_pricing_const = Admin::Pricing::Const.new
    if Admin::Pricing::Const.count > 0
      @admin_pricing_const = Admin::Pricing::Const.last
    end
  end

  # GET /admin/pricing/consts/1/edit
  def edit
  end

  # POST /admin/pricing/consts
  # POST /admin/pricing/consts.json
  def create
    @admin_pricing_const = Admin::Pricing::Const.new(admin_pricing_const_params)

    respond_to do |format|
      if @admin_pricing_const.save
        format.html { redirect_to admin_pricing_consts_path, notice: mk_notice(@admin_pricing_const, :id, 'Const', :create) }
        format.json { render json: @admin_pricing_const, status: :created, location: admin_pricing_consts_path }
      else
        format.html { render :new }
        format.json { render json: @admin_pricing_const.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pricing/consts/1
  # PATCH/PUT /admin/pricing/consts/1.json
  def update
    respond_to do |format|
      if @admin_pricing_const.update(admin_pricing_const_params)
        format.html { redirect_to admin_pricing_consts_path, notice: mk_notice(@admin_pricing_const, :id, 'Const', :update) }
        format.json { render json: @admin_pricing_const, status: :ok, location: admin_pricing_consts_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_pricing_const.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pricing/consts/1
  # DELETE /admin/pricing/consts/1.json
  def destroy
    @admin_pricing_const.destroy
    respond_to do |format|
      format.html { redirect_to admin_pricing_consts_path, notice: mk_notice(@admin_pricing_const, :id, 'Const', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_pricing_const
      @admin_pricing_const = Admin::Pricing::Const.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_pricing_const_params
      params.require(:admin_pricing_const).permit(:guni, :chasb, :payemobl, :sage, :mikh, :cushin, :extra)
    end
end
