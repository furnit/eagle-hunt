class FurnitauresController < ApplicationController
  before_action :set_furnitaure, only: [:show, :edit, :update, :destroy]

  # GET /furnitaures
  # GET /furnitaures.json
  def index
    @furnitaures = Furnitaure.all
  end

  # GET /furnitaures/1
  # GET /furnitaures/1.json
  def show
  end

  # GET /furnitaures/new
  def new
    @furnitaure = Furnitaure.new
  end

  # GET /furnitaures/1/edit
  def edit
  end

  # POST /furnitaures
  # POST /furnitaures.json
  def create
    @furnitaure = Furnitaure.new(furnitaure_params)

    respond_to do |format|
      if @furnitaure.save
        format.html { redirect_to @furnitaure, notice: 'Furnitaure was successfully created.' }
        format.json { render :show, status: :created, location: @furnitaure }
      else
        format.html { render :new }
        format.json { render json: @furnitaure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /furnitaures/1
  # PATCH/PUT /furnitaures/1.json
  def update
    respond_to do |format|
      if @furnitaure.update(furnitaure_params)
        format.html { redirect_to @furnitaure, notice: 'Furnitaure was successfully updated.' }
        format.json { render :show, status: :ok, location: @furnitaure }
      else
        format.html { render :edit }
        format.json { render json: @furnitaure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /furnitaures/1
  # DELETE /furnitaures/1.json
  def destroy
    @furnitaure.destroy
    respond_to do |format|
      format.html { redirect_to furnitaures_url, notice: 'Furnitaure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_furnitaure
      @furnitaure = Furnitaure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def furnitaure_params
      params.require(:furnitaure).permit(:name, :furnitaure_detail_id, :furnitaure_wage_id, :comment)
    end
end
