class Order::OrdersController < ApplicationController
  before_action :set_order_order, only: [:show, :edit, :update, :destroy]

  # GET /order/orders
  # GET /order/orders.json
  def index
    @order_orders = Order::Order.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @order_orders.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /order/orders/1
  # GET /order/orders/1.json
  def show
  end

  # GET /order/orders/new
  def new
    @order_order = Order::Order.new
  end

  # GET /order/orders/1/edit
  def edit
  end

  # POST /order/orders
  # POST /order/orders.json
  def create
    @order_order = Order::Order.new(order_order_params)

    respond_to do |format|
      if @order_order.save
        format.html { redirect_to order_orders_path, notice: mk_notice(@order_order, :id, 'Order', :create) }
        format.json { render json: @order_order, status: :created, location: order_orders_path }
      else
        format.html { render :new }
        format.json { render json: @order_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order/orders/1
  # PATCH/PUT /order/orders/1.json
  def update
    respond_to do |format|
      if @order_order.update(order_order_params)
        format.html { redirect_to order_orders_path, notice: mk_notice(@order_order, :id, 'Order', :update) }
        format.json { render json: @order_order, status: :ok, location: order_orders_path }
      else
        format.html { render :edit }
        format.json { render json: @order_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order/orders/1
  # DELETE /order/orders/1.json
  def destroy
    @order_order.destroy
    respond_to do |format|
      format.html { redirect_to order_orders_path, notice: mk_notice(@order_order, :id, 'Order', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_order
      @order_order = Order::Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_order_params
      params.require(:order_order).permit(:user_id, :admin_furniture_furniture_id, :admin_furniture_fabric_fabric, :fabric_id, :admin_furniture_paint_color_id, :admin_furniture_wood_types_id)
    end
end
