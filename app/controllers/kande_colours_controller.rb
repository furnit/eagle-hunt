class KandeColoursController < ApplicationController
  before_action :set_kande_colour, only: [:show, :edit, :update, :destroy]

  # GET /kande_colours
  # GET /kande_colours.json
  def index
    @kande_colours = KandeColour.all
  end

  # GET /kande_colours/1
  # GET /kande_colours/1.json
  def show
  end

  # GET /kande_colours/new
  def new
    @kande_colour = KandeColour.new
  end

  # GET /kande_colours/1/edit
  def edit
  end

  # POST /kande_colours
  # POST /kande_colours.json
  def create
    @kande_colour = KandeColour.new(kande_colour_params)

    respond_to do |format|
      if @kande_colour.save
        format.html { redirect_to @kande_colour, notice: 'Kande colour was successfully created.' }
        format.json { render :show, status: :created, location: @kande_colour }
      else
        format.html { render :new }
        format.json { render json: @kande_colour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kande_colours/1
  # PATCH/PUT /kande_colours/1.json
  def update
    respond_to do |format|
      if @kande_colour.update(kande_colour_params)
        format.html { redirect_to @kande_colour, notice: 'Kande colour was successfully updated.' }
        format.json { render :show, status: :ok, location: @kande_colour }
      else
        format.html { render :edit }
        format.json { render json: @kande_colour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kande_colours/1
  # DELETE /kande_colours/1.json
  def destroy
    @kande_colour.destroy
    respond_to do |format|
      format.html { redirect_to kande_colours_url, notice: 'Kande colour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kande_colour
      @kande_colour = KandeColour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kande_colour_params
      params.require(:kande_colour).permit(:details, :cost)
    end
end
