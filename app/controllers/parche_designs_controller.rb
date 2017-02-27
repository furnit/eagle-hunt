class ParcheDesignsController < ApplicationController
  before_action :set_parche_design, only: [:show, :edit, :update, :destroy]

  # GET /parche_designs
  # GET /parche_designs.json
  def index
    @parche_designs = ParcheDesign.all
  end

  # GET /parche_designs/1
  # GET /parche_designs/1.json
  def show
  end

  # GET /parche_designs/new
  def new
    @parche_design = ParcheDesign.new
  end

  # GET /parche_designs/1/edit
  def edit
  end

  # POST /parche_designs
  # POST /parche_designs.json
  def create
    @parche_design = ParcheDesign.new(parche_design_params)

    respond_to do |format|
      if @parche_design.save
        format.html { redirect_to @parche_design, notice: 'Parche design was successfully created.' }
        format.json { render :show, status: :created, location: @parche_design }
      else
        format.html { render :new }
        format.json { render json: @parche_design.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parche_designs/1
  # PATCH/PUT /parche_designs/1.json
  def update
    respond_to do |format|
      if @parche_design.update(parche_design_params)
        format.html { redirect_to @parche_design, notice: 'Parche design was successfully updated.' }
        format.json { render :show, status: :ok, location: @parche_design }
      else
        format.html { render :edit }
        format.json { render json: @parche_design.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parche_designs/1
  # DELETE /parche_designs/1.json
  def destroy
    @parche_design.destroy
    respond_to do |format|
      format.html { redirect_to parche_designs_url, notice: 'Parche design was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parche_design
      @parche_design = ParcheDesign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parche_design_params
      params.require(:parche_design).permit(:details, :cost)
    end
end
