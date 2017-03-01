class FurnituresController < ApplicationController
  before_action :define_step, only: [:new]
  before_action :ensure_step, only: [:create, :update, :edit]
  before_action :set_furniture, only: [:show, :edit, :update, :destroy]

  # GET /furnitures
  # GET /furnitures.json
  def index
    @furnitures = Furniture.all
  end

  # GET /furnitures/1
  # GET /furnitures/1.json
  def show
  end

  # GET /furnitures/new
  def new
    @furniture = Furniture.new
  end

  # GET /furnitures/1/edit
  def edit
  end

  # POST /furnitures
  def create
    @furniture = Furniture.new(furniture_params)
    if @furniture.save
      redirect_to edit_furniture_path @furniture, :step => 2
    else
      render :new
    end
  end

  # PATCH/PUT /furnitures/1
  def update
    if @furniture.update(furniture_params)
      if @step < 3
        redirect_to edit_furniture_path @furniture, :step => @step + 1
      else
        redirect_to @furniture, notice: 'Furniture was successfully updated/created.'
      end
    else
      render :edit
    end
  end

  # DELETE /furnitures/1
  # DELETE /furnitures/1.json
  def destroy
    @furniture.destroy
    respond_to do |format|
      format.html { redirect_to furnitures_url, notice: 'Furniture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def define_step
      @step = 1
    end
    
    def ensure_step
      if params[:step] == nil
        params[:step] = 1
      elsif params[:step].to_i > 3
        redirect_to '/422.html'
      end
      @step = params[:step].to_i
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_furniture
      @furniture = Furniture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def furniture_params
      params.require(:furniture).permit(:name, :size_parche, :size_kanaf, :size_abr, :available, :wage_khayat, :wage_rokob, :wage_naghash, :wage_najar, :wage_extra, :comment, {images: []}, :furniture_type_id)
    end
end
