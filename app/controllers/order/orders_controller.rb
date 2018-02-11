class Order::OrdersController < ApplicationController
  # for computing transit cost
  include ApiHelper

  before_action :authenticate_user!, except: [:new]
  before_action :prepare_for_order, only: [:new, :simple, :advance]
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

  def simple
    # only load the view
  end

  def advance
    # only load the view
    # set the initial order details
    session[:order] = {
      furniture: @furniture,
      # define the all steps needs to be taken
      order_steps: (1..6).to_a,
      steps: { }
    }
    # remove the wood step if not required
    session[:order][:order_steps].delete 3 if not(@furniture.employee_fanis.first.needs_kande and @furniture.employee_fanis.first.needs_rang)
  end

  def advance_steps
    # current step#
    step_id = params.require(:step_id).to_i
    # previous step#
    prev_step_id = params.require(:prev_step_id).to_i
    # check the step# range
    raise RuntimeError.new("invalid step#id") if not session[:order][:order_steps].include? step_id
    # check the prev-step# range
    raise RuntimeError.new("invalid prev-step#id") if not session[:order][:order_steps].include? prev_step_id
    # validate the order details in session
    raise RuntimeError.new("invalid request") if session[:order].nil? or session[:order][:furniture].nil?
    # find the related furniture details
    @furniture = Admin::Furniture::Furniture.find(params.require(:f))
    # store/restore the provided ordering data for the step
    if(not params[:details].nil?)
      # check if any details passed?
      if params.has_key? :details
        # set the details for previous step
        session[:order][:steps][prev_step_id] = params[:details].permit!.to_h
      else
        session[:order][:steps][prev_step_id] = { }
      end
    end
    # restore any data avail for this step
    @prev_data = session[:order][:steps][step_id]
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
    # cannot order with an un-verified order pending
    raise ClientError.new('این محصول را قبلا سفارش داده‌اید و در دست بررسی قرار دارد و تا زمانی که این محصول در دست بررسی قرار دارد امکان سفارش مجدد آن وجود ندارد.') if Order::Order.exists?(user_id: current_user.id, admin_furniture_furniture_id: furniture.id, verified: false)
    # check if selected exists in the furniture's images
    is_related = furniture.images.map { |i| i[:id] == pars[:selected_model].to_i }.any?
    # raise error if data are not valid
    raise RuntimeError.new('sent data are not valid.') if not is_related
    # add the order
    Order::Order.create!(user_id: current_user.id, admin_furniture_furniture_id: furniture.id, is_default: true, default_id: pars[:selected_model], verified: false)
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

  def submit_advance
    addresses = params.require([:state_id, :address])
    transit_cost  = ApiHelper.compute_transit_cost params.permit(:state_id, :workshop_id), method: AppConfig.preference.price.transit.compute_method
    # create new order instance
    order = Order::Order.new(user: current_user, admin_furniture_furniture_id: session[:order][:furniture].id, order_details: session[:order], state: addresses.first, address: addresses.last, is_default: 0, verified: 0)
    # if order couldn't be saved
    if not order.save
      respond_to do |format|
        format.json { render json: order.errors, status: :unprocessable_entity }
      end
    end
    payment = Admin::Selling::Payment::Payment.new(order: order, amount: session[:order][:final][:pricing][:total_price] + transit_cost)
    byebug

    respond_to do |format|
      format.json { render json: { }, status: :ok }
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
      # restore the details' data
      if @prev_data and @prev_data[:section_model] and @prev_data[:section_model].is_a?(Hash)
        @prev_data[:section_model].values.each do |v|
          # fetch the fabric model using its ID
          v[:model] = Admin::Furniture::Fabric::Model.find(v[:model_id])
        end
      end
    end

    def advance_step3
      @wood_types = Admin::Pricing::Wood.all.map { |w| w.type }
      @wood_colors = Admin::Furniture::Wood::Color.all
      @wood_color_weights = Admin::Furniture::Wood::ColorWeight.all
    end

    def advance_step4
    end

    def advance_step5
      @data = session[:order][:steps].dup
      maps = {
        "زیری": :ziri,
        "دسته": :daste,
        "پشتی": :poshti
      }
      factors = {
        fabrics: { }
      }
      @data.each do |steps, pars|
        case steps
        when 1
          # convert config to integer
          @data[1][:config] = @data[1][:config].map(&:to_i)
        when 2
          # fetch selected models
          pars[:section_model].values.each do |v|
            # fetch the section using its ID
            v[:section] = Admin::Furniture::Section.find v[:sec_id]
            # fetch the fabric model using its ID
            v[:model] = Admin::Furniture::Fabric::Model.find v[:model_id]
            # add it to the fabric factors
            factors[:fabrics][maps[v[:section].name.to_sym]] = v[:model].fabric
          end
        when 3
          @data[3][:wood_type] = Admin::Pricing::Wood.find(pars[:wood_type_id])
          @data[3][:wood_color] = Admin::Furniture::Wood::Color.find(pars[:wood_color_id])
          @data[3][:wood_color_weight] = Admin::Furniture::Wood::ColorWeight.find(pars[:wood_color_weight_id])
        when 4
          # pass; do nothing
          @data[4][:extra_cushin] ||= 0
        end
      end
      factors = factors.merge({
        const: Admin::Pricing::Const.last,
        paint_color: Admin::Pricing::PaintColor.find_by(admin_furniture_paint_color_brand_id: Admin::Furniture::Paint::ColorBrand.where(is_default: true).first.id),
        paint_astar_rouye: Admin::Pricing::PaintAstarRouye.last,
        wood: @data[3][:wood_type],
        kalaf: Admin::Pricing::Kalaf.last
      })
      # compute price with it's profit margin considered
      @cost = @furniture.compute_price factors: factors, set: @data[1][:config], profit_margin: (@furniture.price.profit / 100.0)
      # add extra cushin prices
      @cost[:overall] += @data[4][:extra_cushin].to_i * factors[:const][:cushin]
      # store the computed price and processed history to the session
      session[:order][:final] = {
        data: @data,
        pricing: {
          factors: factors,
          total_price: @cost[:overall]
        }
      }
    end

    def advance_step6
      @cost = session[:order][:final][:pricing][:total_price].to_i;
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_order
      @order_order = Order::Order.find(params[:id])
    end

    def prepare_for_order
      # delete previous order data
      session.delete :order
      # create new order
      @order = Order::Order.new
      # find the related furniture details
      @furniture = Admin::Furniture::Furniture.find(params.require(:f))
      # raise if request's params are not compatible
      raise Exception.new("id & key does not match!") if params.require(:h) != get_hash(@furniture.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_order_params
      params.require(:order_order).permit(:user_id, :admin_furniture_furniture_id, :admin_furniture_fabric_fabric, :fabric_id, :admin_furniture_paint_color_id, :admin_furniture_wood_types_id)
    end
end
