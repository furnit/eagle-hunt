class Admin::Furniture::PiecesController < Admin::AdminbaseController
  before_action :set_admin_furniture_piece, only: [:show, :edit, :update, :destroy]

  # GET /admin/furniture/pieces
  # GET /admin/furniture/pieces.json
  def index
    @admin_furniture_pieces = Admin::Furniture::Piece.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_furniture_pieces.map { |i| { value: i.id, text: i.piece } }, status: :ok }
    end
  end

  # GET /admin/furniture/pieces/1
  # GET /admin/furniture/pieces/1.json
  def show
  end

  # GET /admin/furniture/pieces/new
  def new
    @admin_furniture_piece = Admin::Furniture::Piece.new
  end

  # GET /admin/furniture/pieces/1/edit
  def edit
  end

  # POST /admin/furniture/pieces
  # POST /admin/furniture/pieces.json
  def create
    @admin_furniture_piece = Admin::Furniture::Piece.new(admin_furniture_piece_params)

    respond_to do |format|
      if @admin_furniture_piece.save
        format.html { redirect_to admin_furniture_pieces_path, notice: mk_notice(@admin_furniture_piece, :piece, 'تعداد', :create) }
        format.json { render json: @admin_furniture_piece, status: :created, location: admin_furniture_pieces_path }
      else
        format.html { render :new }
        format.json { render json: @admin_furniture_piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/furniture/pieces/1
  # PATCH/PUT /admin/furniture/pieces/1.json
  def update
    respond_to do |format|
      if @admin_furniture_piece.update(admin_furniture_piece_params)
        format.html { redirect_to admin_furniture_pieces_path, notice: mk_notice(@admin_furniture_piece, :piece, 'تعداد', :update) }
        format.json { render json: @admin_furniture_piece, status: :ok, location: admin_furniture_pieces_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_furniture_piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/furniture/pieces/1
  # DELETE /admin/furniture/pieces/1.json
  def destroy
    @admin_furniture_piece.destroy
    respond_to do |format|
      format.html { redirect_to admin_furniture_pieces_path, notice: mk_notice(@admin_furniture_piece, :piece, 'تعداد', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_furniture_piece
      @admin_furniture_piece = Admin::Furniture::Piece.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_furniture_piece_params
      params.require(:admin_furniture_piece).permit(:piece, :comment)
    end
end
