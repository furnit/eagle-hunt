class Employee::EmployeebaseController < ApplicationController
  layout :get_layout
  
  def get_layout
    return false if ["new", "edit", "create"].include? params[:action]
    return 'no_navbar'
  end
end
