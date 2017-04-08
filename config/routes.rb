require_relative 'routes/general.rb'
require_relative 'routes/admin.rb'

Rails.application.routes.draw do
  
  namespace :employee do
    get 'home/index'
  end

  extend GeneralRoutes 
  
  extend AdminRoutes

end
