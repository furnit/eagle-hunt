class HomeController < ApplicationController
	def index
  	@categories = Admin::FurnitureType.all
	end
	
	def category
    @furniture_type = Admin::FurnitureType.find(params[:id])
    # if image list is nill? make it an empty array
    @furniture_type.images ||= []
    # fetch from database
    @furniture = @furniture_type.furniture
	end
	
	def furniture
	  @furniture = Admin::Furniture.find(params[:id]) 
	end
	
	def furniture_notify
	  # verify the recaptcha
	  if not verify_recaptcha
      respond_to do |format|
        format.json { render json: {message: "احراز هویت به درستی صورت نگرفته است، لطفا دوباره تلاش کنید."}, status: :unprocessable_entity }
      end
      return
	  end
	  
	  success_notice = 'شماره شما با موفقیت ثبت گردید.' 
	  
	  # either the user is signed in and we obtain the number from the profile or get it from form
	  phone_number = user_signed_in? ? current_user.phone_number : params[:phone_number]
	  
	  # all deletions are valid by default!
	  valid = !params[:checked].to_boolean;
	  
	  # if we should add it to database?
	  if params[:checked].to_boolean
	    valid = NotifyOnFurnitureAvailable.find_or_create_by(phone_number: phone_number, admin_furniture_id: params[:fid]).errors.empty?
	  else
	    # we should delete from database
	    success_notice = 'شماره شما با موفقیت از لیست پیگیری‌های این محصول حذف گردید.' 
	    NotifyOnFurnitureAvailable.delete_all(phone_number: current_user.phone_number, admin_furniture_id: params[:fid]) if user_signed_in?
	  end
	  
    respond_to do |format|
  	  if valid 
  	    format.json { render json: {message: success_notice}, status: :ok }
	    else
  	    format.json { render json: {message: "خطا در ثبت اطلاعات، لطفا دوباره تلاش کنید."}, status: :unprocessable_entity }
  	  end
	  end
	end
	
	def contactus
	end
end
