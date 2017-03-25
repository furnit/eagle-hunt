class ApplicationController < ActionController::Base
  # no forgery!
  protect_from_forgery with: :exception
  # if user's profile not set, acquire it!
  before_action :acquire_profile_if_necessary
  # disables the layout for AJAX calls   
  layout proc { false if request.xhr? }
  
  def acquire_profile_if_necessary
    if user_signed_in? and not current_user.profile
      redirect_to new_profile_path
    end
  end
  
  protected
  
  def prevent_browser_caching
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate' # HTTP 1.1.
    response.headers['Pragma'] = 'no-cache' # HTTP 1.0.
    response.headers['Expires'] = '0' # Proxies.
  end
  
end
