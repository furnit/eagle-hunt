class AvailWorkshopsController < ApplicationController
  before_action :set_avail_workshop, only: [:show, :edit, :update, :destroy]

  # GET /avail_workshops
  # GET /avail_workshops.json
  def index
    @avail_workshops = AvailWorkshop.all
  end

  # GET /avail_workshops/1
  # GET /avail_workshops/1.json
  def show
  end

  # GET /avail_workshops/new
  def new
    @avail_workshop = AvailWorkshop.new
  end

  # GET /avail_workshops/1/edit
  def edit
  end

  # POST /avail_workshops
  # POST /avail_workshops.json
  def create
    @avail_workshop = AvailWorkshop.new(avail_workshop_params)

    respond_to do |format|
      if @avail_workshop.save
        format.html { redirect_to @avail_workshop, notice: 'Avail workshop was successfully created.' }
        format.json { render :show, status: :created, location: @avail_workshop }
      else
        format.html { render :new }
        format.json { render json: @avail_workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /avail_workshops/1
  # PATCH/PUT /avail_workshops/1.json
  def update
    respond_to do |format|
      if @avail_workshop.update(avail_workshop_params)
        format.html { redirect_to @avail_workshop, notice: 'Avail workshop was successfully updated.' }
        format.json { render :show, status: :ok, location: @avail_workshop }
      else
        format.html { render :edit }
        format.json { render json: @avail_workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /avail_workshops/1
  # DELETE /avail_workshops/1.json
  def destroy
    @avail_workshop.destroy
    respond_to do |format|
      format.html { redirect_to avail_workshops_url, notice: 'Avail workshop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avail_workshop
      @avail_workshop = AvailWorkshop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def avail_workshop_params
      params.require(:avail_workshop).permit(:furniture_id, :workshop_id, :proposed_cost)
    end
end
