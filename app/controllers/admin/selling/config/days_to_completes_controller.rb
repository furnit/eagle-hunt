class Admin::Selling::Config::DaysToCompletesController < Admin::AdminbaseController
  before_action :set_admin_selling_config_days_to_complete, only: [:show, :edit, :update, :destroy]

  # GET /admin/selling/config/days_to_completes
  # GET /admin/selling/config/days_to_completes.json
  def index
    @admin_selling_config_days_to_completes = Admin::Selling::Config::DaysToComplete.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_selling_config_days_to_completes.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/selling/config/days_to_completes/1
  # GET /admin/selling/config/days_to_completes/1.json
  def show
  end

  # GET /admin/selling/config/days_to_completes/new
  def new
    @admin_selling_config_days_to_complete = Admin::Selling::Config::DaysToComplete.new
  end

  # GET /admin/selling/config/days_to_completes/1/edit
  def edit
  end

  # POST /admin/selling/config/days_to_completes
  # POST /admin/selling/config/days_to_completes.json
  def create
    @admin_selling_config_days_to_complete = Admin::Selling::Config::DaysToComplete.new(admin_selling_config_days_to_complete_params)

    respond_to do |format|
      if @admin_selling_config_days_to_complete.save
        format.html { redirect_to admin_selling_config_days_to_completes_path, notice: mk_notice(@admin_selling_config_days_to_complete, :id, 'Days to complete', :create) }
        format.json { render json: @admin_selling_config_days_to_complete, status: :created, location: admin_selling_config_days_to_completes_path }
      else
        format.html { render :new }
        format.json { render json: @admin_selling_config_days_to_complete.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/selling/config/days_to_completes/1
  # PATCH/PUT /admin/selling/config/days_to_completes/1.json
  def update
    respond_to do |format|
      if @admin_selling_config_days_to_complete.update(admin_selling_config_days_to_complete_params)
        format.html { redirect_to admin_selling_config_days_to_completes_path, notice: mk_notice(@admin_selling_config_days_to_complete, :id, 'Days to complete', :update) }
        format.json { render json: @admin_selling_config_days_to_complete, status: :ok, location: admin_selling_config_days_to_completes_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_selling_config_days_to_complete.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/selling/config/days_to_completes/1
  # DELETE /admin/selling/config/days_to_completes/1.json
  def destroy
    @admin_selling_config_days_to_complete.destroy
    respond_to do |format|
      format.html { redirect_to admin_selling_config_days_to_completes_path, notice: mk_notice(@admin_selling_config_days_to_complete, :id, 'Days to complete', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_selling_config_days_to_complete
      @admin_selling_config_days_to_complete = Admin::Selling::Config::DaysToComplete.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_selling_config_days_to_complete_params
      params.require(:admin_selling_config_days_to_complete).permit(:extra)
    end
end
