class SittingSetsController < ApplicationController
  before_action :set_sitting_set, only: [:show, :edit, :update, :destroy]

  # GET /sitting_sets
  # GET /sitting_sets.json
  def index
    @sitting_sets = SittingSet.all
  end

  # GET /sitting_sets/1
  # GET /sitting_sets/1.json
  def show
  end

  # GET /sitting_sets/new
  def new
    @sitting_set = SittingSet.new
  end

  # GET /sitting_sets/1/edit
  def edit
  end

  # POST /sitting_sets
  # POST /sitting_sets.json
  def create
    @sitting_set = SittingSet.new(sitting_set_params)

    respond_to do |format|
      if @sitting_set.save
        format.html { redirect_to @sitting_set, notice: 'Sitting set was successfully created.' }
        format.json { render :show, status: :created, location: @sitting_set }
      else
        format.html { render :new }
        format.json { render json: @sitting_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sitting_sets/1
  # PATCH/PUT /sitting_sets/1.json
  def update
    respond_to do |format|
      if @sitting_set.update(sitting_set_params)
        format.html { redirect_to @sitting_set, notice: 'Sitting set was successfully updated.' }
        format.json { render :show, status: :ok, location: @sitting_set }
      else
        format.html { render :edit }
        format.json { render json: @sitting_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sitting_sets/1
  # DELETE /sitting_sets/1.json
  def destroy
    @sitting_set.destroy
    respond_to do |format|
      format.html { redirect_to sitting_sets_url, notice: 'Sitting set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sitting_set
      @sitting_set = SittingSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sitting_set_params
      params.require(:sitting_set).permit(:count, :details, :comment)
    end
end
