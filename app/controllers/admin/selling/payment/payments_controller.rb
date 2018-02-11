class Admin::Selling::Payment::PaymentsController < ApplicationController
  before_action :set_admin_selling_payment_payment, only: [:show, :edit, :update, :destroy]

  # GET /admin/selling/payment/payments
  # GET /admin/selling/payment/payments.json
  def index
    @admin_selling_payment_payments = Admin::Selling::Payment::Payment.all.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @admin_selling_payment_payments.map { |i| { value: i.id, text: i.to_s } }, status: :ok }
    end
  end

  # GET /admin/selling/payment/payments/1
  # GET /admin/selling/payment/payments/1.json
  def show
  end

  # GET /admin/selling/payment/payments/new
  def new
    @admin_selling_payment_payment = Admin::Selling::Payment::Payment.new
  end

  # GET /admin/selling/payment/payments/1/edit
  def edit
  end

  # POST /admin/selling/payment/payments
  # POST /admin/selling/payment/payments.json
  def create
    @admin_selling_payment_payment = Admin::Selling::Payment::Payment.new(admin_selling_payment_payment_params)

    respond_to do |format|
      if @admin_selling_payment_payment.save
        format.html { redirect_to admin_selling_payment_payments_path, notice: mk_notice(@admin_selling_payment_payment, :id, 'Payment', :create) }
        format.json { render json: @admin_selling_payment_payment, status: :created, location: admin_selling_payment_payments_path }
      else
        format.html { render :new }
        format.json { render json: @admin_selling_payment_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/selling/payment/payments/1
  # PATCH/PUT /admin/selling/payment/payments/1.json
  def update
    respond_to do |format|
      if @admin_selling_payment_payment.update(admin_selling_payment_payment_params)
        format.html { redirect_to admin_selling_payment_payments_path, notice: mk_notice(@admin_selling_payment_payment, :id, 'Payment', :update) }
        format.json { render json: @admin_selling_payment_payment, status: :ok, location: admin_selling_payment_payments_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_selling_payment_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/selling/payment/payments/1
  # DELETE /admin/selling/payment/payments/1.json
  def destroy
    @admin_selling_payment_payment.destroy
    respond_to do |format|
      format.html { redirect_to admin_selling_payment_payments_path, notice: mk_notice(@admin_selling_payment_payment, :id, 'Payment', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_selling_payment_payment
      @admin_selling_payment_payment = Admin::Selling::Payment::Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_selling_payment_payment_params
      params.require(:admin_selling_payment_payment).permit(:order/order_id, :amount, :trans_id, :status)
    end
end
