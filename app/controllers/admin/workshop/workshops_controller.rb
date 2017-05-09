class Admin::Workshop::WorkshopsController < Admin::AdminbaseController
  before_action :set_admin_workshop_workshop, only: [:show, :edit, :update, :destroy, :toggle_cease]

  # GET /admin/workshop/workshops
  # GET /admin/workshop/workshops.json
  def index
    @admin_workshop_workshops = Admin::Workshop::Workshop.paginate(page: params[:page])
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
        format.html { redirect_to admin_workshop_workshops_path, notice: mk_notice(@admin_workshop_workshop, :name, 'کارگاه', :create) }
        format.json { render json: @admin_workshop_workshop, status: :created, location: admin_workshop_workshops_path }
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
        format.html { redirect_to admin_workshop_workshops_path, notice: mk_notice(@admin_workshop_workshop, :name, 'کارگاه', :update)}
        format.json { render json: @admin_workshop_workshop, status: :ok, location: admin_workshop_workshops_path }
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
      format.html { redirect_to admin_workshop_workshops_path, notice: mk_notice(@admin_workshop_workshop, :name, 'کارگاه', :delete) }
      format.json { head :no_content }
    end
  end

  # PUT
  def toggle_cease
    label = ""
    if @admin_workshop_workshop.ceased_at.nil?
      @admin_workshop_workshop.ceased_at = Time.now
      label = "متوقف"
    else
      @admin_workshop_workshop.ceased_at = nil
      label = "اجرا"
    end
    
    respond_to do |format|
      if @admin_workshop_workshop.save
        format.html { redirect_to admin_workshop_workshops_path, notice: "ادامه‌ی همکاری با کارگاه «<b>#{@admin_workshop_workshop.name}</b>» با موفقیت «<b>#{label}</b>» شد."}
        format.json { render json: @admin_workshop_workshop, status: :ok, location: admin_workshop_workshops_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_workshop_workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_workshop_workshop
      @admin_workshop_workshop = Admin::Workshop::Workshop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_workshop_workshop_params
      params.require(:admin_workshop_workshop).permit(:name, :state_id, :address, :user_id, :phone_number, :comment, :ceased_at)
    end
end
