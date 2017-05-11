class ApplicationController < ActionController::Base
  # no forgery!
  protect_from_forgery with: :exception
  # gaurd the project by Access Controll Unit
  before_action { Acu::Monitor.gaurd by: { user: current_user } }
  # signout's the account if admin becomde inactivate for some time
  before_action :guard_admin_with_last_access_expiration
  # set prefered layout
  layout :prefer_layout
  # if user's profile not set, acquire it!
  before_action :acquire_profile_if_necessary
  # change user's password if flaged to change?
  before_action :change_user_password_if_necessary
  # add to phonebook if necessary
  before_action :add_to_phonebook_if_necessary
  # translates every params' entity from arabic to english 
  before_action :param_convert_ar2en_i
  
  private

  def guard_admin_with_last_access_expiration
    # for admin users ONLY
    acu_as :admin do
      # fetch session details from db
      isession = session_data
      # init `last_accessed_at` expired?
      if isession.last_accessed_at and (isession.last_accessed_at + eval(AppConfig.session.admin.expiration) < Time.now)
        # signout the user
        sign_out_and_redirect(current_user)
        # delete session from db
        isession.destroy
        # indicate the error message
        flash[:error] = "مهلت زمانی استفاده‌ی حساب شما منقضی شده است، لطفا دوباره وارد شوید."
        return
      end
      # if session was not expired?
      # update the last access time
      isession.last_accessed_at = Time.now
      # store into db
      isession.save
      # check if session verified since this is an admin?
      if isession.verified_at.nil?
        return if params["controller"] == "users/sessions" and [:verify, :confirm, :destroy].include? params["action"].to_sym
        session[:request_for_signin_verification] = true
        redirect_to users_sign_in_verify_path
        return
      else
        session.delete :request_for_signin_verification
      end
    end
  end

  def param_convert_ar2en_i h = nil, l = [], depth: 0
    h ||= params
    h.each_pair do |k, v|
      if v.respond_to? :key?
        param_convert_ar2en_i v, [l, k].flatten, depth: depth + 1
      else
        if h[k].respond_to? :each
          h[k].each { |i| i.to_ar2en_i if i.respond_to? :to_ar2en_i }
        else
          h[k].to_ar2en_i if h[k].respond_to? :to_ar2en_i 
        end
      end
    end
  end

  def verify_two_step_auth
    if not two_step_auth.verified? params, exception: false
      respond_to do |format|
        format.json { render json: {status: :failed, cause: :two_step_auth, message: 'رمز موقت معتبر نیست، باید دوباره تقاضای دریافت رمز موقت نمایید.'}, status: :unprocessable_entity }
        yield format if block_given?
      end
      return false
    end
    return true
  end
  
  def session_data
    raise RuntimeError.new("invalid cookie") if cookies[SESSION_KEY].blank?
    SessionStore.find_by_session_id cookies[SESSION_KEY]
  end

  def acquire_profile_if_necessary
    if user_signed_in? and not current_user.profile
      redirect_to new_profile_path
    end
  end

  def change_user_password_if_necessary
    return if performed?
    if user_signed_in? and current_user.change_password and not(["users/sessions", "users/registrations"].include? params["controller"] or (params["controller"] == "users/sessions" and params["action"] == "destroy"))
      flash[:alert] = "شما باید رمز عبور خود را بروز رسانی کنید."
      redirect_to edit_user_registration_path
    end
  end
  
  def mk_notice instance, field, label, op
    op = {
      create: 'ایجاد',
      update: 'ویرایش',
      delete: 'حذف'
    }[op.to_sym]
    "#{label} «<b>#{eval("instance.#{field.to_s}")}</b>» با موفقیت #{op} شد." 
  end
  
  def add_to_phonebook_if_necessary
    if user_signed_in? and current_user.profile and not(current_user.is_added_to_phonebook or current_user.error_on_add_to_phonebook)
      require "#{Rails.root}/lib/sms/bootstrap"
      if not SMS.add_to_phonebook first_name: current_user.profile.first_name, last_name: current_user.profile.last_name, mobile: current_user.phone_number 
        message = <<~sms
          خطای اضافه کردن به دفترچه تلفن
          کاربر: #{current_user.id}
          
          مبل ویرا
          #{AppConfig.domain}
        sms
        # if we sent the warning to ALL admins registered in database
        AutoStart::SmsJob.send_proper message, to: Admin::UserType.where(symbol: :ADMIN).first.users.map { |u| u.phone_number }.join(',')
        # suppress the following trials of adding the user to the phonebook
        # it had to be the admin's job to try to put or leave it!
        current_user.error_on_add_to_phonebook = true
      else
        current_user.is_added_to_phonebook = true
      end
      current_user.save
    end
  end
  
  protected
  
  def two_step_auth
    ::TwoStepAuth.new current_user
  end
  
  def prefer_layout lyout = nil
    return 'ajax' if is_ajax_call?
    lyout
  end

  def is_ajax_call?
    not request.xhr?.nil?
  end

  def prevent_browser_caching
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate' # HTTP 1.1.
    response.headers['Pragma'] = 'no-cache' # HTTP 1.0.
    response.headers['Expires'] = '0' # Proxies.
  end

end
