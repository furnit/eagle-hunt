class TransferCostsController < ApplicationController
  before_action :set_transfer_cost, only: [:show, :edit, :update, :destroy]

  # GET /transfer_costs
  # GET /transfer_costs.json
  def index
    @transfer_costs = TransferCost.all
  end

  # GET /transfer_costs/1
  # GET /transfer_costs/1.json
  def show
  end

  # GET /transfer_costs/new
  def new
    @transfer_cost = TransferCost.new
  end

  # GET /transfer_costs/1/edit
  def edit
  end

  # POST /transfer_costs
  # POST /transfer_costs.json
  def create
    @transfer_cost = TransferCost.new(transfer_cost_params)

    respond_to do |format|
      if @transfer_cost.save
        format.html { redirect_to @transfer_cost, notice: 'Transfer cost was successfully created.' }
        format.json { render :show, status: :created, location: @transfer_cost }
      else
        format.html { render :new }
        format.json { render json: @transfer_cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transfer_costs/1
  # PATCH/PUT /transfer_costs/1.json
  def update
    respond_to do |format|
      if @transfer_cost.update(transfer_cost_params)
        format.html { redirect_to @transfer_cost, notice: 'Transfer cost was successfully updated.' }
        format.json { render :show, status: :ok, location: @transfer_cost }
      else
        format.html { render :edit }
        format.json { render json: @transfer_cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transfer_costs/1
  # DELETE /transfer_costs/1.json
  def destroy
    @transfer_cost.destroy
    respond_to do |format|
      format.html { redirect_to transfer_costs_url, notice: 'Transfer cost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer_cost
      @transfer_cost = TransferCost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transfer_cost_params
      params.require(:transfer_cost).permit(:title, :cost, :comment)
    end
end
