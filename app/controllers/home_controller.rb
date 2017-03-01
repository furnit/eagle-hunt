class HomeController < ApplicationController
	def index
    	@categories = FurnitureType.all
	end
end
