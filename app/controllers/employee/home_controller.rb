class Employee::HomeController < ApplicationController
  def index
  end
  
  def as
    session[:admin_as_employee] = Admin::UserType.find(params[:as_employee]).name
    respond_to do |format|
      format.html { redirect_to employee_root_path }
    end
  end
end
