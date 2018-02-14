class Admin::Selling::Order::OrdersController < Admin::AdminbaseController
  before_action :set_admin_selling_order_order, only: [:show, :edit, :update, :destroy]

  # GET /admin/selling/order/orders
  # GET /admin/selling/order/orders.json
  def index
    @admin_selling_order_orders = Order::Order.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_selling_order_orders.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/selling/order/orders/1
  # GET /admin/selling/order/orders/1.json
  def show
  end

  # GET /admin/selling/order/orders/new
  def new
    @admin_selling_order_order = Admin::Selling::Order::Order.new
  end

  # GET /admin/selling/order/orders/1/edit
  def edit
  end

  # POST /admin/selling/order/orders
  # POST /admin/selling/order/orders.json
  def create
    @admin_selling_order_order = Admin::Selling::Order::Order.new(admin_selling_order_order_params)

    respond_to do |format|
      if @admin_selling_order_order.save
        format.html { redirect_to admin_selling_order_orders_path, notice: mk_notice(@admin_selling_order_order, :id, 'Order', :create) }
        format.json { render json: @admin_selling_order_order, status: :created, location: admin_selling_order_orders_path }
      else
        format.html { render :new }
        format.json { render json: @admin_selling_order_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/selling/order/orders/1
  # PATCH/PUT /admin/selling/order/orders/1.json
  def update
    respond_to do |format|
      if @admin_selling_order_order.update(admin_selling_order_order_params)
        format.html { redirect_to admin_selling_order_orders_path, notice: mk_notice(@admin_selling_order_order, :id, 'Order', :update) }
        format.json { render json: @admin_selling_order_order, status: :ok, location: admin_selling_order_orders_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_selling_order_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/selling/order/orders/1
  # DELETE /admin/selling/order/orders/1.json
  def destroy
    @admin_selling_order_order.destroy
    respond_to do |format|
      format.html { redirect_to admin_selling_order_orders_path, notice: mk_notice(@admin_selling_order_order, :id, 'Order', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_selling_order_order
      @admin_selling_order_order = Admin::Selling::Order::Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_selling_order_order_params
      params.fetch(:admin_selling_order_order, {})
    end
end
