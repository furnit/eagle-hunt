class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # pre-fetch the user to check if blocked or recovered
    user = User.authenticate(sign_in_params[:phone_number], sign_in_params[:password])
    # due to issue devise#4484 and since I already fetched the user,
    # if it's authenticated, then going to manually sign_in the user :)
    if user
      # check the blocked before trying to recover the user
      if not user.blocked_at.nil?
        destroy
        flash.delete :notice
        flash[:error] = "<b>متاسفانه حساب کاربری شما مسدود گردیده است.</b>
        <br />اگر فکر می‌کنید این یک خطا می‌باشد، می‌توانید با بخش مدیریت سایت تماس حاصل فرمایید تا به مشکل هرچه زودتر رسیدگی شود!";
        redirect_to root_path
        return
      end
      # ok, the user is not blocked :)
      # check for it's suspension
      if not user.deleted_at.nil?
        user.recover
        flash[:alert] = 'حساب کاربری شما فعال شد!'
      end
      
      if user.type.symbol == :ADMIN.to_s
        message = <<~sms
          مدیر‌گرامی
          هم‌اکنون حساب کاربری شما مورد دسترسی واقع شده است.
          
          مبل ویرا
          #{AppConfig.domain}
        sms
        
        AutoStart::SmsJob.send_urgent message, to: user.phone_number
      end
      
      # user is authenticated, sign in the good boy
      sign_in_and_redirect(:user, user)
      return
    end
    # call the devise, if user is not authenticated!
    super
  end
  
  def verify    
    redirect_to root_path if not session[:request_for_signin_verification]
    
    @isession = session_data
    @isession.verification_token = rand.to_s[2..(2 + AppConfig.passwords.two_step_auth.token_length - 1)].to_s
    @isession.verification_send_at = Time.now
    @isession.save 
    
    message = <<~sms
      رمز موقت
      #{@isession.verification_token}
      
      مبل ویرا
      #{AppConfig.domain}
    sms
    
    AutoStart::SmsJob.send_urgent message, to: current_user.phone_number
  end
  
  def confirm
    @isession = session_data
    # verify the recaptcha
    if not verify_recaptcha
      flash[:recaptcha_error] = true
      render :verify
      return
    end
    
    # check if code expired?
    if (@isession.verification_send_at and (@isession.verification_send_at + eval(AppConfig.passwords.two_step_auth.send_expiration) < Time.now))
      # the code is expired, have to re-send it
      @isession.verification_token = nil
      @isession.verification_send_at = nil
      @isession.save    
      respond_to do |format|
        format.html { render :verify }
        format.json { render json: 'code expired', status: :unprocessable_entity }
      end
      return
    end
    
    # check if code match?
    if @isession.verification_token == params.require(@isession.model_name.param_key)[:verification_token]
      @isession.verified_at = Time.now
      @isession.save
      
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { head :no_content, status: :ok }
      end
      return
    end
    
    # o.w
    respond_to do |format|
      @isession.errors[:verification_token] = 'کد وارد شده اشتباه است!'
      format.html { render :verify }
      format.json { render json: @isession.errors, status: unprocessable_entity }
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
