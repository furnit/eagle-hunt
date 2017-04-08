class Employee::HomeController < ApplicationController
  def index
  end
  
  # post /employee/as
  def as
    e = Admin::UserType.find(params[:as_employee])
    session[:admin_as_employee] = {name: e.name, id: e.id, sym: e.symbol}
    respond_to do |format|
      format.html { redirect_to employee_root_path }
    end
  rescue ActiveRecord::RecordNotFound
    session.delete :admin_as_employee
    redirect_to employee_root_path
  end
end
