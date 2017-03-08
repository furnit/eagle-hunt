class HomeController < ApplicationController
	def index
  	@categories = FurnitureType.all
	end
	
	def contactus
	end
end
