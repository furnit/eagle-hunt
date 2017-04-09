require_relative 'routes/general.rb'
require_relative 'routes/admin.rb'
require_relative 'routes/employee.rb'

Rails.application.routes.draw do
  
  extend GeneralRoutes 
  
  extend AdminRoutes
  
  extend EmployeeRoutes

end
