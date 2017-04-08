class Employee::HomeController < ApplicationController
  def index
  end
  
  def as
    session_namespace[:as] = Admin::UserType.find(params[:as_employee]).readonly!
    respond_to do |format|
      format.html { redirect_to employee_root_path }
    end
  end
end
