class FurnitureWagesController < ApplicationController
  before_action :set_furniture_wage, only: [:show, :edit, :update, :destroy]

  # GET /furniture_wages
  # GET /furniture_wages.json
  def index
    @furniture_wages = FurnitureWage.all
  end

  # GET /furniture_wages/1
  # GET /furniture_wages/1.json
  def show
  end

  # GET /furniture_wages/new
  def new
    @furniture_wage = FurnitureWage.new
  end

  # GET /furniture_wages/1/edit
  def edit
  end

  # POST /furniture_wages
  # POST /furniture_wages.json
  def create
    @furniture_wage = FurnitureWage.new(furniture_wage_params)

    respond_to do |format|
      if @furniture_wage.save
        format.html { redirect_to @furniture_wage, notice: 'Furniture wage was successfully created.' }
        format.json { render :show, status: :created, location: @furniture_wage }
      else
        format.html { render :new }
        format.json { render json: @furniture_wage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /furniture_wages/1
  # PATCH/PUT /furniture_wages/1.json
  def update
    respond_to do |format|
      if @furniture_wage.update(furniture_wage_params)
        format.html { redirect_to @furniture_wage, notice: 'Furniture wage was successfully updated.' }
        format.json { render :show, status: :ok, location: @furniture_wage }
      else
        format.html { render :edit }
        format.json { render json: @furniture_wage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /furniture_wages/1
  # DELETE /furniture_wages/1.json
  def destroy
    @furniture_wage.destroy
    respond_to do |format|
      format.html { redirect_to furniture_wages_url, notice: 'Furniture wage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_furniture_wage
      @furniture_wage = FurnitureWage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def furniture_wage_params
      params.require(:furniture_wage).permit(:khayat, :rokob, :naghash, :naja, :extra, :comment)
    end
end
