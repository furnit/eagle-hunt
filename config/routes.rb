require_relative 'routes/general.rb'
require_relative 'routes/admin.rb'

Rails.application.routes.draw do
  
  extend GeneralRoutes 
  
  extend AdminRoutes

end
