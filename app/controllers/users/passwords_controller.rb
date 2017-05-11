class Users::PasswordsController < Devise::PasswordsController
  prepend_before_action :check_captcha, only: [:create, :reset]
  
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    def fail_with_message message
      self.resource = User.new
      self.resource.errors[:phone_number] = message
      respond_to do |format|
        format.html { render :new }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
    # check if the phone number actually exists in database?
    @user = User.find_by phone_number: resource_params[:phone_number]
    if not @user
      fail_with_message 'شماره موبایل در سامانه ثبت نشده است.'
      return
    end
    # else if user found
    # send the confirmation code
    @user.reset_password_token = rand.to_s[2..(2 + AppConfig.passwords.reset.token_length - 1)].to_s
    @user.reset_password_sent_at = Time.now
    
    require "#{Rails.root}/lib/sms/bootstrap"
    
    message = <<~sms
      کد #{AppConfig.passwords.reset.token_length} رقمی شما: #{@user.reset_password_token}
      
      مبل ویرا
      #{AppConfig.domain}
    sms
    
    if not AutoStart::SmsJob.send_urgent message, to: @user.phone_number
      fail_with_message 'امکان ارسال پیام به این شماره وجود ندارد، لطفا با تیم مدیریت سایت تماس حاصل فرمایید.'
      return
    end
    
    if not @user.save
      fail_with_message 'عملیات با خطا مواجه شده است - پیام ارسالی را نادیده بگیرید و تیم مدیریت سایت را مطلع کنید.'
      return
    end
    
    respond_to do |format|
      require 'digest'
      format.html { redirect_to users_password_confirm_path(id: @user.id, h: Digest::SHA256.hexdigest("%s.%s" %[@user.id, @user.phone_number])), notice: 'پیام کوتاه با موفقیت ارسال شد!' }
      format.json { render json: @user, status: :ok }
    end
  end

  def confirm
    @user = User.find(params[:id])
    raise Acu::Errors::AccessDenied.new("you don't have permission to execute this operation") if Digest::SHA256.hexdigest("%s.%s" %[@user.id, @user.phone_number]) != params[:h]
  end
  
  def reset
    @user = User.find(resource_params[:id])
    # check if code expired?
    if (@user.reset_password_sent_at and (@user.reset_password_sent_at + eval(AppConfig.passwords.reset.expiration) < Time.now))
      # the code is expired, have to re-send it
      @user.reset_password_token = nil
      @user.reset_password_sent_at = nil
      @user.save    
      respond_to do |format|
        format.html { render :confirm }
        format.json { render json: 'code expired', status: :unprocessable_entity }
      end
      return
    end
    # check if code match?
    if @user.reset_password_token == resource_params[:reset_token]
      @user.reset_password
      @user.save
      
      respond_to do |format|
        format.html { redirect_to new_user_session_path, flash: { success: 'رمز عبور با موفقیت به <b>شماره موبایل‌تان</b> تغییر پیدا کرد!'}}
        format.json { head :no_content, status: :ok }
      end
      return
    end
    # o.w
    respond_to do |format|
      @user.errors[:reset_token] = 'کد وارد شده اشتباه است!'
      format.html { render :confirm }
      format.json { render json: @user.errors, status: :ok, location: admin_users_path }
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  protected
  
  def check_captcha
    views = {
      create: :new,
      reset:  :confirm 
    }
    unless verify_recaptcha
      case params[:action].to_sym
      when :reset
        @user = User.find(params.require(:user).permit(:id)[:id])
      else
        self.resource = resource_class.new
      end
      respond_with_navigational(resource) { render views[params[:action].to_sym] }
    end
      
  end

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
