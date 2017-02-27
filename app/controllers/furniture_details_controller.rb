class FurnitureDetailsController < ApplicationController
  before_action :set_furniture_detail, only: [:show, :edit, :update, :destroy]

  # GET /furniture_details
  # GET /furniture_details.json
  def index
    @furniture_details = FurnitureDetail.all
  end

  # GET /furniture_details/1
  # GET /furniture_details/1.json
  def show
  end

  # GET /furniture_details/new
  def new
    @furniture_detail = FurnitureDetail.new
  end

  # GET /furniture_details/1/edit
  def edit
  end

  # POST /furniture_details
  # POST /furniture_details.json
  def create
    @furniture_detail = FurnitureDetail.new(furniture_detail_params)

    respond_to do |format|
      if @furniture_detail.save
        format.html { redirect_to @furniture_detail, notice: 'Furniture detail was successfully created.' }
        format.json { render :show, status: :created, location: @furniture_detail }
      else
        format.html { render :new }
        format.json { render json: @furniture_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /furniture_details/1
  # PATCH/PUT /furniture_details/1.json
  def update
    respond_to do |format|
      if @furniture_detail.update(furniture_detail_params)
        format.html { redirect_to @furniture_detail, notice: 'Furniture detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @furniture_detail }
      else
        format.html { render :edit }
        format.json { render json: @furniture_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /furniture_details/1
  # DELETE /furniture_details/1.json
  def destroy
    @furniture_detail.destroy
    respond_to do |format|
      format.html { redirect_to furniture_details_url, notice: 'Furniture detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_furniture_detail
      @furniture_detail = FurnitureDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def furniture_detail_params
      params.require(:furniture_detail).permit(:size_parche, :size_kanaf, :size_abr, :available, :images)
    end
end
