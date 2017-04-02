class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # pre-fetch the user to see if it is the comming back user or not
    user = User.authenticate(sign_in_params[:phone_number], sign_in_params[:password])
    # if this is a comming back user recover the user instance to allow the devise to the rest of the job
    if user
      user.recover and user.save
      flash[:alert] = 'حساب کاربری شما دوباره فعال شد!'
    end
    # call the devise
    super
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
