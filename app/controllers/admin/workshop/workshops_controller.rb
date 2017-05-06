class Admin::Workshop::WorkshopsController < ApplicationController
  before_action :set_admin_workshop_workshop, only: [:show, :edit, :update, :destroy]

  # GET /admin/workshop/workshops
  # GET /admin/workshop/workshops.json
  def index
    @admin_workshop_workshops = Admin::Workshop::Workshop.all
  end

  # GET /admin/workshop/workshops/1
  # GET /admin/workshop/workshops/1.json
  def show
  end

  # GET /admin/workshop/workshops/new
  def new
    @admin_workshop_workshop = Admin::Workshop::Workshop.new
  end

  # GET /admin/workshop/workshops/1/edit
  def edit
  end

  # POST /admin/workshop/workshops
  # POST /admin/workshop/workshops.json
  def create
    @admin_workshop_workshop = Admin::Workshop::Workshop.new(admin_workshop_workshop_params)

    respond_to do |format|
      if @admin_workshop_workshop.save
        format.html { redirect_to @admin_workshop_workshop, notice: 'Workshop was successfully created.' }
        format.json { render :show, status: :created, location: @admin_workshop_workshop }
      else
        format.html { render :new }
        format.json { render json: @admin_workshop_workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/workshop/workshops/1
  # PATCH/PUT /admin/workshop/workshops/1.json
  def update
    respond_to do |format|
      if @admin_workshop_workshop.update(admin_workshop_workshop_params)
        format.html { redirect_to @admin_workshop_workshop, notice: 'Workshop was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_workshop_workshop }
      else
        format.html { render :edit }
        format.json { render json: @admin_workshop_workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/workshop/workshops/1
  # DELETE /admin/workshop/workshops/1.json
  def destroy
    @admin_workshop_workshop.destroy
    respond_to do |format|
      format.html { redirect_to admin_workshop_workshops_url, notice: 'Workshop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_workshop_workshop
      @admin_workshop_workshop = Admin::Workshop::Workshop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_workshop_workshop_params
      params.require(:admin_workshop_workshop).permit(:name, :state_id, :address, :user_id, :phone_number, :comment)
    end
end
