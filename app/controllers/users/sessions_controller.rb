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
      if user.blocked_at
        destroy
        flash.delete :notice
        flash[:error] = "<b>متاسفانه حساب کاربری شما مسدود گردیده است.</b>
        <br />اگر فکر می‌کنید این یک خطا می‌باشد، می‌توانید با بخش مدیریت سایت تماس حاصل فرمایید تا به مشکل هرچه زودتر رسیدگی شود!";
        redirect_to root_path
        return
      end
      # ok, the user is not blocked :)
      # check for it's suspension
      if user.deleted_at
        user.recover
        flash[:alert] = 'حساب کاربری شما فعال شد!'
      end
      # user is authenticated, sign in the good boy
      sign_in_and_redirect(:user, user)
      return
    end
    # call the devise, if user is not authenticated!
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
