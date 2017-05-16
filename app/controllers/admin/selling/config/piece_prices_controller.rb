class Admin::Selling::Config::PiecePricesController < Admin::AdminbaseController
  before_action :set_admin_selling_config_piece_price, only: [:show, :edit, :update, :destroy]

  # GET /admin/selling/config/piece_prices
  # GET /admin/selling/config/piece_prices.json
  def index
    @admin_selling_config_piece_prices = Admin::Selling::Config::PiecePrice.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_selling_config_piece_prices.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/selling/config/piece_prices/1
  # GET /admin/selling/config/piece_prices/1.json
  def show
  end

  # GET /admin/selling/config/piece_prices/new
  def new
    @admin_selling_config_piece_price = Admin::Selling::Config::PiecePrice.new
  end

  # GET /admin/selling/config/piece_prices/1/edit
  def edit
  end

  # POST /admin/selling/config/piece_prices
  # POST /admin/selling/config/piece_prices.json
  def create
    @admin_selling_config_piece_price = Admin::Selling::Config::PiecePrice.new(admin_selling_config_piece_price_params)

    respond_to do |format|
      if @admin_selling_config_piece_price.save
        format.html { redirect_to admin_selling_config_piece_prices_path, notice: mk_notice(@admin_selling_config_piece_price, :id, 'Piece price', :create) }
        format.json { render json: @admin_selling_config_piece_price, status: :created, location: admin_selling_config_piece_prices_path }
      else
        format.html { render :new }
        format.json { render json: @admin_selling_config_piece_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/selling/config/piece_prices/1
  # PATCH/PUT /admin/selling/config/piece_prices/1.json
  def update
    respond_to do |format|
      if @admin_selling_config_piece_price.update(admin_selling_config_piece_price_params)
        format.html { redirect_to admin_selling_config_piece_prices_path, notice: mk_notice(@admin_selling_config_piece_price, :id, 'Piece price', :update) }
        format.json { render json: @admin_selling_config_piece_price, status: :ok, location: admin_selling_config_piece_prices_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_selling_config_piece_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/selling/config/piece_prices/1
  # DELETE /admin/selling/config/piece_prices/1.json
  def destroy
    @admin_selling_config_piece_price.destroy
    respond_to do |format|
      format.html { redirect_to admin_selling_config_piece_prices_path, notice: mk_notice(@admin_selling_config_piece_price, :id, 'Piece price', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_selling_config_piece_price
      @admin_selling_config_piece_price = Admin::Selling::Config::PiecePrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_selling_config_piece_price_params
      params.require(:admin_selling_config_piece_price).permit(:admin_furniture_set_id, :piece, :percentage, :comment)
    end
end
