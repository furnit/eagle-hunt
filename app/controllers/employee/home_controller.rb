class Employee::HomeController < ApplicationController
  layout 'no_navbar', only: [:ls_furnitures]
  
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
  
  def ls_furnitures
    @furnitures = Admin::Furniture.paginate(:page => params[:page], per_page: 3)
    30.times { @furnitures += @furnitures }
    respond_to do |format|
      format.html
      format.js
    end
  end
end
