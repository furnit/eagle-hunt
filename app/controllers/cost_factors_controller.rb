class CostFactorsController < ApplicationController
  before_action :set_cost_factor, only: [:show, :edit, :update, :destroy]

  # GET /cost_factors
  # GET /cost_factors.json
  def index
    @cost_factors = CostFactor.all
  end

  # GET /cost_factors/1
  # GET /cost_factors/1.json
  def show
  end

  # GET /cost_factors/new
  def new
    @cost_factor = CostFactor.new
  end

  # GET /cost_factors/1/edit
  def edit
  end

  # POST /cost_factors
  # POST /cost_factors.json
  def create
    @cost_factor = CostFactor.new(cost_factor_params)

    respond_to do |format|
      if @cost_factor.save
        format.html { redirect_to @cost_factor, notice: 'Cost factor was successfully created.' }
        format.json { render :show, status: :created, location: @cost_factor }
      else
        format.html { render :new }
        format.json { render json: @cost_factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cost_factors/1
  # PATCH/PUT /cost_factors/1.json
  def update
    respond_to do |format|
      if @cost_factor.update(cost_factor_params)
        format.html { redirect_to @cost_factor, notice: 'Cost factor was successfully updated.' }
        format.json { render :show, status: :ok, location: @cost_factor }
      else
        format.html { render :edit }
        format.json { render json: @cost_factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cost_factors/1
  # DELETE /cost_factors/1.json
  def destroy
    @cost_factor.destroy
    respond_to do |format|
      format.html { redirect_to cost_factors_url, notice: 'Cost factor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cost_factor
      @cost_factor = CostFactor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cost_factor_params
      params.require(:cost_factor).permit(:size_parche, :size_kanaf, :size_abr, :wage_khayat, :wage_rokob, :wage_naghash, :wage_najar, :parche_colour, :parche_design, :kande_colours, :kande_design, :transfer_cost, :extras, :profit_percentage)
    end
end
