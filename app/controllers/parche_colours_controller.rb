class ParcheColoursController < ApplicationController
  before_action :set_parche_colour, only: [:show, :edit, :update, :destroy]

  # GET /parche_colours
  # GET /parche_colours.json
  def index
    @parche_colours = ParcheColour.all
  end

  # GET /parche_colours/1
  # GET /parche_colours/1.json
  def show
  end

  # GET /parche_colours/new
  def new
    @parche_colour = ParcheColour.new
  end

  # GET /parche_colours/1/edit
  def edit
  end

  # POST /parche_colours
  # POST /parche_colours.json
  def create
    @parche_colour = ParcheColour.new(parche_colour_params)

    respond_to do |format|
      if @parche_colour.save
        format.html { redirect_to @parche_colour, notice: 'Parche colour was successfully created.' }
        format.json { render :show, status: :created, location: @parche_colour }
      else
        format.html { render :new }
        format.json { render json: @parche_colour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parche_colours/1
  # PATCH/PUT /parche_colours/1.json
  def update
    respond_to do |format|
      if @parche_colour.update(parche_colour_params)
        format.html { redirect_to @parche_colour, notice: 'Parche colour was successfully updated.' }
        format.json { render :show, status: :ok, location: @parche_colour }
      else
        format.html { render :edit }
        format.json { render json: @parche_colour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parche_colours/1
  # DELETE /parche_colours/1.json
  def destroy
    @parche_colour.destroy
    respond_to do |format|
      format.html { redirect_to parche_colours_url, notice: 'Parche colour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parche_colour
      @parche_colour = ParcheColour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parche_colour_params
      params.require(:parche_colour).permit(:details, :cost)
    end
end
