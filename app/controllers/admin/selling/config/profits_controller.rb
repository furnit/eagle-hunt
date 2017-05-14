class Admin::Selling::Config::ProfitsController < Admin::AdminbaseController
  before_action :set_admin_selling_config_profit, only: [:show, :edit, :update, :destroy]

  # GET /admin/selling/config/profits
  # GET /admin/selling/config/profits.json
  def index
    @admin_selling_config_profits = [Admin::Selling::Config::Profit.last] - [nil]

    respond_to do |format|
      format.html
      format.json { render json: @admin_selling_config_profits.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/selling/config/profits/1
  # GET /admin/selling/config/profits/1.json
  def show
  end

  # GET /admin/selling/config/profits/new
  def new
    @admin_selling_config_profit = Admin::Selling::Config::Profit.new
  end

  # GET /admin/selling/config/profits/1/edit
  def edit
  end

  # POST /admin/selling/config/profits
  # POST /admin/selling/config/profits.json
  def create
    @admin_selling_config_profit = Admin::Selling::Config::Profit.new(admin_selling_config_profit_params)

    respond_to do |format|
      if @admin_selling_config_profit.save
        format.html { redirect_to admin_selling_config_profits_path, notice: mk_notice(@admin_selling_config_profit, :id, 'Profit', :create) }
        format.json { render json: @admin_selling_config_profit, status: :created, location: admin_selling_config_profits_path }
      else
        format.html { render :new }
        format.json { render json: @admin_selling_config_profit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/selling/config/profits/1
  # PATCH/PUT /admin/selling/config/profits/1.json
  def update
    respond_to do |format|
      if @admin_selling_config_profit.update(admin_selling_config_profit_params)
        format.html { redirect_to admin_selling_config_profits_path, notice: mk_notice(@admin_selling_config_profit, :id, 'Profit', :update) }
        format.json { render json: @admin_selling_config_profit, status: :ok, location: admin_selling_config_profits_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_selling_config_profit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/selling/config/profits/1
  # DELETE /admin/selling/config/profits/1.json
  def destroy
    @admin_selling_config_profit.destroy
    respond_to do |format|
      format.html { redirect_to admin_selling_config_profits_path, notice: mk_notice(@admin_selling_config_profit, :id, 'Profit', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_selling_config_profit
      @admin_selling_config_profit = Admin::Selling::Config::Profit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_selling_config_profit_params
      params.require(:admin_selling_config_profit).permit(:overall, :overall_fixed, :marketer, :marketer_fixed, :marketed, :marketed_fixed)
    end
end
