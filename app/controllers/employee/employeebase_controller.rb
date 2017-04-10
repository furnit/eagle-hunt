class Employee::EmployeebaseController < ApplicationController
  layout 'no_navbar'
  before_action :no_layout, only: [:new]
  
  def no_layout
    render layout: false
  end
end
