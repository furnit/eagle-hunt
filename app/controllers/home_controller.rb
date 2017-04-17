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
	  require "uri"
    require "net/http"
	  params = {
	    secret: AppConfig.recaptcha.keys.secret,
	    response: params["g-recaptcha-response"],
	    remoteip: request.remote_ip
	  }
	  byebug
	  x = Net::HTTP.post_form(URI.parse(AppConfig.recaptcha.verify), params)
	  
	end
	
	def contactus
	end
end
