class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :acquire_profile_if_necessary
  
  def acquire_profile_if_necessary
    if user_signed_in? and not current_user.profile
      redirect_to new_profile_path
    end
  end
end
