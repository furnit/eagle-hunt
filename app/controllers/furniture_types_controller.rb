class FurnitureTypesController < ApplicationController
  before_action :set_furniture_type, only: [:show, :edit, :update, :destroy]

  # GET /furniture_types
  # GET /furniture_types.json
  def index
    @furniture_types = FurnitureType.all
  end

  # GET /furniture_types/1
  # GET /furniture_types/1.json
  def show
  end

  # GET /furniture_types/new
  def new
    @furniture_type = FurnitureType.new
  end

  # GET /furniture_types/1/edit
  def edit
  end

  # POST /furniture_types
  # POST /furniture_types.json
  def create
    @furniture_type = FurnitureType.new(furniture_type_params)

    respond_to do |format|
      if @furniture_type.save
        format.html { redirect_to @furniture_type, notice: 'Furniture type was successfully created.' }
        format.json { render :show, status: :created, location: @furniture_type }
      else
        format.html { render :new }
        format.json { render json: @furniture_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /furniture_types/1
  # PATCH/PUT /furniture_types/1.json
  def update
    respond_to do |format|
      if @furniture_type.update(furniture_type_params)
        format.html { redirect_to @furniture_type, notice: 'Furniture type was successfully updated.' }
        format.json { render :show, status: :ok, location: @furniture_type }
      else
        format.html { render :edit }
        format.json { render json: @furniture_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /furniture_types/1
  # DELETE /furniture_types/1.json
  def destroy
    @furniture_type.destroy
    respond_to do |format|
      format.html { redirect_to furniture_types_url, notice: 'Furniture type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_furniture_type
      @furniture_type = FurnitureType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def furniture_type_params
      params.require(:furniture_type).permit(:name, :comment, {images: []})
    end
end
