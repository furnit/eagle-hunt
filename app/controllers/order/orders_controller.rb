class Order::OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  before_action :set_order_furniture, only: [:new, :simple, :advance]
  before_action :set_order_order, only: [:show, :edit, :update, :destroy]
  before_action only: [:new, :simple, :advance] do
    @order = Order::Order.new
  end

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

  def simple
    # only load the view
  end

  def advance
  end

  def advance_steps
    step_id = params.require(:step_id).to_i
    raise RuntimeError.new("invalid step#id") if not step_id.between?(1, 5)

    # store/restore the provided ordering data for the step

    # call the related handler to the step
    eval("advance_step#{step_id}")
    # render the related view
    render "advance_step#{step_id}"
  end

  def submit_simple
    pars = params.require(:order_order).permit(:selected_model, :admin_furniture_furniture_id);
    # find the furniture first
    furniture = Admin::Furniture::Furniture.find(pars[:admin_furniture_furniture_id]);
    # flag it if not available
    raise ClientError.new('این محصول قابل سفارش نمی‌باشد.') if not furniture.available
    # cannot order with an un-resolved order pending
    raise ClientError.new('این محصول را قبلا سفارش داده‌اید و در دست بررسی قرار دارد و تا زمانی که این محصول در دست بررسی قرار دارد امکان سفارش مجدد آن وجود ندارد.') if Order::Order.exists?(user_id: current_user.id, admin_furniture_furniture_id: furniture.id, resolved: false)
    # check if selected exists in the furniture's images
    is_related = furniture.images.map { |i| i[:id] == pars[:selected_model].to_i }.any?
    # raise error if data are not valid
    raise RuntimeError.new('sent data are not valid.') if not is_related
    # add the order
    Order::Order.create!(user_id: current_user.id, admin_furniture_furniture_id: furniture.id, is_default: true, default_id: pars[:selected_model], resolved: false)
    # provide proper respond
    @title = 'سفارش ثبت و در صف بررسی قرار گرفت!'
    @body = 'به زودی از همکاران ما تماسی جهت تکمیل سفارش دریافت خواهید کرد.'

    respond_to do |format|
      format.json { render json: { title: @title, body: @body }, status: :ok }
    end

  rescue ClientError => e
    respond_to do |format|
      format.json { render json: { title: 'خطا در سفارش!', body: e.message }, status: :unprocessable_entity }
    end
  end

  protected
    def advance_step1
      @default_sets = Admin::Furniture::Set.all
      @defined_pieces = Admin::Furniture::Piece.all
    end

    def advance_step2
      @furniture_sections = Admin::Furniture::Section.where(tag: :NECESSARY)
      @fabric_quals = Admin::Furniture::Fabric::Quality.all
      @colors_categories = Admin::Furniture::Fabric::Color.all
    end

    def advance_step3
      @wood_types = Admin::Pricing::Wood.all.map { |w| w.type }
      @wood_colors = Admin::Furniture::Wood::Color.all
      @wood_color_weights = Admin::Furniture::Wood::ColorWeight.all
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_order
      @order_order = Order::Order.find(params[:id])
    end

    def set_order_furniture
      @furniture = Admin::Furniture::Furniture.find(params.require(:f))
      raise Exception.new("id & key does not match!") if params.require(:h) != get_hash(@furniture.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_order_params
      params.require(:order_order).permit(:user_id, :admin_furniture_furniture_id, :admin_furniture_fabric_fabric, :fabric_id, :admin_furniture_paint_color_id, :admin_furniture_wood_types_id)
    end
end
