class ApplicationController < ActionController::Base
  # no forgery!
  protect_from_forgery with: :exception
  # for `current_page?`
  include ActionView::Helpers::UrlHelper
  # if user's profile not set, acquire it!
  before_action :acquire_profile_if_necessary
  # change user's password if flaged to change?
  before_action :change_user_password_if_necessary
  # disables the layout for AJAX calls
  layout proc { false if request.xhr? }

  before_action { Acu::Monitor.gaurd by: { user: current_user } }

  def acquire_profile_if_necessary
    if user_signed_in? and not current_user.profile
      redirect_to new_profile_path
    end
  end

  def change_user_password_if_necessary
    if user_signed_in? and current_user.change_password and params["controller"] != "users/registrations"
      flash[:notice] = "شما باید رمز عبور خود را بروز رسانی کنید."
      redirect_to edit_user_registration_path
    end
  end

  protected

  def prevent_browser_caching
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate' # HTTP 1.1.
    response.headers['Pragma'] = 'no-cache' # HTTP 1.0.
    response.headers['Expires'] = '0' # Proxies.
  end

end
