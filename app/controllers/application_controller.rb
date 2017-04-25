class ApplicationController < ActionController::Base
  # no forgery!
  protect_from_forgery with: :exception
  # set prefered layout
  layout :prefer_layout
  # if user's profile not set, acquire it!
  before_action :acquire_profile_if_necessary
  # change user's password if flaged to change?
  before_action :change_user_password_if_necessary
  # add to phonebook if necessary
  before_action :add_to_phonebook_if_necessary

  before_action { Acu::Monitor.gaurd by: { user: current_user } }

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  
  private

  def acquire_profile_if_necessary
    if user_signed_in? and not current_user.profile
      redirect_to new_profile_path
    end
  end

  def change_user_password_if_necessary
    if user_signed_in? and current_user.change_password and not(params["controller"] == "users/registrations" or (params["controller"] == "users/sessions" and params["action"] == "destroy"))
      flash[:alert] = "شما باید رمز عبور خود را بروز رسانی کنید."
      redirect_to edit_user_registration_path
    end
  end
  
  def add_to_phonebook_if_necessary
    if user_signed_in? and current_user.profile and not(current_user.is_added_to_phonebook or current_user.error_on_add_to_phonebook)
      require "#{Rails.root}/lib/sms/bootstrap"
      if not SMS.add_to_phonebook first_name: current_user.profile.first_name, last_name: current_user.profile.last_name, mobile: current_user.phone_number 
        message = <<~sms
          خطای اضافه کردن کاربر به دفترچه تلفن
          ##{current_user.id}
          
          مبل ویرا
          #{AppConfig.domain}
        sms
        # if we sent the warning to admin
        if AutoStart::SmsJob.send_proper message, to: User.find(1).phone_number
          # suppress the following trials of adding the user to the phonebook
          # it had to be the admin's job to try to put or leave it!
          current_user.error_on_add_to_phonebook = true
        end
      else
        current_user.is_added_to_phonebook = true
      end
      current_user.save
    end
  end
  
  protected

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
