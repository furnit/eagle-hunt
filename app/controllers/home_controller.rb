class HomeController < ApplicationController
	def index
    	@furnitures = Furniture.all
	end
end
