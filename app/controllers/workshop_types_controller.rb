class WorkshopTypesController < ApplicationController
  before_action :set_workshop_type, only: [:show, :edit, :update, :destroy]

  # GET /workshop_types
  # GET /workshop_types.json
  def index
    @workshop_types = WorkshopType.all
  end

  # GET /workshop_types/1
  # GET /workshop_types/1.json
  def show
  end

  # GET /workshop_types/new
  def new
    @workshop_type = WorkshopType.new
  end

  # GET /workshop_types/1/edit
  def edit
  end

  # POST /workshop_types
  # POST /workshop_types.json
  def create
    @workshop_type = WorkshopType.new(workshop_type_params)

    respond_to do |format|
      if @workshop_type.save
        format.html { redirect_to @workshop_type, notice: 'Workshop type was successfully created.' }
        format.json { render :show, status: :created, location: @workshop_type }
      else
        format.html { render :new }
        format.json { render json: @workshop_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workshop_types/1
  # PATCH/PUT /workshop_types/1.json
  def update
    respond_to do |format|
      if @workshop_type.update(workshop_type_params)
        format.html { redirect_to @workshop_type, notice: 'Workshop type was successfully updated.' }
        format.json { render :show, status: :ok, location: @workshop_type }
      else
        format.html { render :edit }
        format.json { render json: @workshop_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workshop_types/1
  # DELETE /workshop_types/1.json
  def destroy
    @workshop_type.destroy
    respond_to do |format|
      format.html { redirect_to workshop_types_url, notice: 'Workshop type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workshop_type
      @workshop_type = WorkshopType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workshop_type_params
      params.require(:workshop_type).permit(:type, :comment)
    end
end
