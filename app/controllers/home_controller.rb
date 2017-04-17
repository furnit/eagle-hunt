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
	  if not verify_recaptcha
      respond_to do |format|
        format.json { render json: {message: "احراز هویت به درستی صورت نگرفته است، لطفا دوباره تلاش کنید."}, status: :unprocessable_entity }
      end
      return
	  end
    respond_to do |format|
  	  if NotifyOnFurnitureAvailable.find_or_create_by(phone_number: params[:phone_number], admin_furniture_id: params[:fid])
  	    format.json { render json: {message: 'شماره شما با موفقیت ثبت گردید.'}, status: :ok }
	    else
  	    format.json { render json: {message: "خطا در ثبت اطلاعات، لطفا دوباره تلاش کنید."}, status: :unprocessable_entity }
  	  end
	  end
	end
	
	def contactus
	end
end
