class FurnitaureWagesController < ApplicationController
  before_action :set_furnitaure_wage, only: [:show, :edit, :update, :destroy]

  # GET /furnitaure_wages
  # GET /furnitaure_wages.json
  def index
    @furnitaure_wages = FurnitaureWage.all
  end

  # GET /furnitaure_wages/1
  # GET /furnitaure_wages/1.json
  def show
  end

  # GET /furnitaure_wages/new
  def new
    @furnitaure_wage = FurnitaureWage.new
  end

  # GET /furnitaure_wages/1/edit
  def edit
  end

  # POST /furnitaure_wages
  # POST /furnitaure_wages.json
  def create
    @furnitaure_wage = FurnitaureWage.new(furnitaure_wage_params)

    respond_to do |format|
      if @furnitaure_wage.save
        format.html { redirect_to @furnitaure_wage, notice: 'Furnitaure wage was successfully created.' }
        format.json { render :show, status: :created, location: @furnitaure_wage }
      else
        format.html { render :new }
        format.json { render json: @furnitaure_wage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /furnitaure_wages/1
  # PATCH/PUT /furnitaure_wages/1.json
  def update
    respond_to do |format|
      if @furnitaure_wage.update(furnitaure_wage_params)
        format.html { redirect_to @furnitaure_wage, notice: 'Furnitaure wage was successfully updated.' }
        format.json { render :show, status: :ok, location: @furnitaure_wage }
      else
        format.html { render :edit }
        format.json { render json: @furnitaure_wage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /furnitaure_wages/1
  # DELETE /furnitaure_wages/1.json
  def destroy
    @furnitaure_wage.destroy
    respond_to do |format|
      format.html { redirect_to furnitaure_wages_url, notice: 'Furnitaure wage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_furnitaure_wage
      @furnitaure_wage = FurnitaureWage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def furnitaure_wage_params
      params.require(:furnitaure_wage).permit(:khayat, :rokob, :naghash, :naja, :extra, :comment)
    end
end
