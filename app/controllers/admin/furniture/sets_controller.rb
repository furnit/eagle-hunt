class Admin::Furniture::SetsController < Admin::AdminbaseController
  before_action :set_admin_furniture_set, only: [:show, :edit, :update, :destroy]

  # GET /admin/furniture/sets
  # GET /admin/furniture/sets.json
  def index
    @admin_furniture_sets = Admin::Furniture::Set.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_furniture_sets.map { |i| { value: i.id, text: "#{i.name} #{i.config.to_s}" } }, status: :ok }
    end
  end

  # GET /admin/furniture/sets/1
  # GET /admin/furniture/sets/1.json
  def show
  end

  # GET /admin/furniture/sets/new
  def new
    @admin_furniture_set = Admin::Furniture::Set.new
  end

  # GET /admin/furniture/sets/1/edit
  def edit
  end

  # POST /admin/furniture/sets
  # POST /admin/furniture/sets.json
  def create
    @admin_furniture_set = Admin::Furniture::Set.new(admin_furniture_set_params)

    respond_to do |format|
      if @admin_furniture_set.save
        format.html { redirect_to admin_furniture_sets_path, notice: mk_notice(@admin_furniture_set, :name, 'ست مبل', :create) }
        format.json { render json: @admin_furniture_set, status: :created, location: admin_furniture_sets_path }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture/sets/1
  # PATCH/PUT /admin/furniture/sets/1.json
  def update
    respond_to do |format|
      if @admin_furniture_set.update(admin_furniture_set_params)
        format.html { redirect_to admin_furniture_sets_path, notice: mk_notice(@admin_furniture_set, :name, 'ست مبل', :update) }
        format.json { render json: @admin_furniture_set, status: :ok, location: admin_furniture_sets_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture/sets/1
  # DELETE /admin/furniture/sets/1.json
  def destroy
    @admin_furniture_set.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_sets_path, notice: mk_notice(@admin_furniture_set, :name, 'ست مبل', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_set
      @admin_furniture_set = Admin::Furniture::Set.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_set_params
      params.require(:admin_furniture_set).permit(:name, :config, :comment)
    end
end
