class HomeController < ApplicationController
	def index
  	@categories = Admin::FurnitureType.all
	end
	
	def category
    @furniture_type = Admin::FurnitureType.find(params[:id])
    # if image list is nill? make it an empty array
    @furniture_type.images ||= []
    # fetch the furnitures
    @furniture = @furniture_type.furniture
	end
	
	def furniture
	  @furniture  = Admin::Furniture.find(params[:id])
	end
	
	def contactus
	end
end
