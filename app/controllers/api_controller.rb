class ApiController < ApplicationController
  # no forgery protection except payment callbacks!
  protect_from_forgery with: :exception, except: [:payment_callback, :payment_test_callback]
  # include api helper
  include ApiHelper

  def ls_fabrics
    quality_id = params.require(:q)
    # limit 1 brand for each quality
    fabrics = Admin::Furniture::Fabric::Fabric.where(admin_furniture_fabric_quality_id: quality_id).paginate(page: params[:page], per_page: 1).map do |fabric|
      build_fabric_detail fabric, fabric.models
    end

    # prepend the meta data
    fabrics = [ {
      meta: {
        total_size: Admin::Furniture::Fabric::Fabric.where(admin_furniture_fabric_quality_id: quality_id).count,
        current_page: params[:page] || 1,
        per_page: 1
      }
    } ] + fabrics

    respond_to do |format|
      format.json { render json: fabrics, status: :ok }
    end
  end

  def ls_fabric_models
    color_code = params.require(:cc)

    all = Admin::Furniture::Fabric::Color.find(color_code).related_models.map do |model|
      build_fabric_detail model.fabric, model
    end

    brands = all.map { |f| f[:brand] }.uniq

    fabrics = { }

    all.each do |f|
      if not fabrics.key? f[:brand]
        fabrics[f[:brand]] = f
      else
        fabrics[f[:brand]][:models] += f[:models]
      end
    end

    fabrics = fabrics.values

    # prepend the meta data
	  # we won't paginate in here
    fabrics = [ {
      meta: {
        total_size: fabrics.length,
        current_page: 1,
        per_page: fabrics.length
      }
    } ] + fabrics

    respond_to do |format|
      format.json { render json: fabrics, status: :ok }
    end
  end

  def transit_price
    method = params.require :method
    price  = ApiHelper.compute_transit_cost params.permit(:state_id, :workshop_id), method: method

    respond_to do |format|
      format.json { render json: { method: method, price: price.to_s.to_money }, status: :ok }
    end
  end

  def payment_test
    # the test amount
    @amount = 100
    # get transaction uri
    @trans = Transaction.get_trans_uri order_id: "-1", amount: @amount, callback_uri: "#{AppConfig.protocol}://#{AppConfig.domain}#{payment_test_callback_api_index_path}"
    # the success message
    @message = "<span class='fa fa-check text-success'></span> در حال انتقال به درگاه پرداخت به جهت پرداخت <b>#{@amount} تومان</b> به جهت تست پرداخت!"
    # store transaction for later investigation
    session[:payment_test] = @trans
  rescue RuntimeError => e
    # the error message
    @message = "<span class='fa fa-times text-danger'></span> خطا در دریافت مجوز تراکنش!<br /><pre>#{e.message}</pre>"
  end

  def payment_test_callback
    # fetch transaction and order IDs
    trans_id, order_id = params.require([:trans_id, :order_id]);
    # fetch pre-stored payment test details from `payment_test`
    @trans = session[:payment_test]
    # if trans record does not exist in session
    raise RuntimeError.new("There is no previously record of test payment in session, please try to test again!") if @trans.nil?
    # if IDs don't match?
    raise RuntimeError.new("The `trans_id`, `order_id` didn't match with stored ones in session!") if not(@trans[:trans_id] == trans_id and @trans[:order_id] == order_id)
    # if the transaction couldn't get verified from the source
    raise RuntimeError.new("Couldn't verify the transaction") if not(Transaction.verify_trans(trans_id: trans_id, order_id: order_id, amount: @trans[:amount]))
    # the success message
    @message = "<span class='fa fa-check text-success'></span> پرداخت مبلغ <b>#{@trans[:amount]} تومان</b> با موفقیت انجام شد.<pre>شماره تراکنش: #{trans_id}</pre>"
  rescue RuntimeError => e
    # the error message
    @message = "<span class='fa fa-times text-danger'></span> خطا در انجام تراکنش!<br /><pre style='direction: ltr'>#{e.message}</pre>"
  ensure
    # remove the previously stored transaction instance
    session.delete :payment_test
  end

  def payment_callback
    # fetch transaction and order IDs
    @trans_id, @order_id = params.require([:trans_id, :order_id]);
    # fetch payment recrod from database
    @payment =  Admin::Selling::Payment::Payment.find_by(trans_id: @trans_id, order_order_id: @order_id);
    # if `payment` does not exist our db
    raise ClientError.new("تراکنش در پایگاه داده‌ی سایت قبلا به ثبت نرسیده است، در صورتی که فکر می‌کنید اشتباه شده است لطفا هرچه سریع‌تر با شماره‌ تراکنش زیر با مدیریت سایت تماس حاصل فرمایید.") if @payment.nil?
    # if the transaction couldn't get verified from the source
    raise ClientError.new("تراکنش موفق نبوده است!") if not(Transaction.verify_trans(trans_id: @trans_id, order_id: @order_id, amount: @payment.amount))
    # set payment status to verified
    @payment.update(status: 1)
    # set success message
    @message = "تراکنش موفق!"
    # set success status
    @status  = :SUCCESS
  rescue ClientError => e
    @message = e.message
    @status  = :FAILED
  end

  protected
    def build_fabric_detail fabric, models
      models = [models].flatten
      {
        price: fabric.price,
        comment: fabric.comment,
        models: models.map { |m| { id: m.id, name: m.public_name, origin: m.image[:image].url, thumb: m.image[:image].thumb.url } },
        quality: {
          id: fabric.quality.id,
          name: fabric.quality.name,
          comment: fabric.quality.comment
        },
        brand: {
          id: fabric.brand.id,
          name: fabric.brand.name,
          comment: fabric.brand.comment,
          available: fabric.brand.available
        }
      }
    end
end
