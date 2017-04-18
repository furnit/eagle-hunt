class Employee::HomeController < ApplicationController
  layout 'no_navbar', only: [:ls_furnitures, :invalid_path]
  
  def index
  end
  
  def invalid_path
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
    @furnitures = ls_furnitures_scop.paginate(:page => params[:page])
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  private 
  
  def ls_furnitures_scop
    symbol = current_user.user_type.symbol;
    acu_as :admin { symbol = session[:admin_as_employee]["sym"] }
    
    not_archived = "NOT"
    not_archived = "" if params[:archived]
    
    query = [
      "`id` #{not_archived} IN (SELECT `admin_furniture_id` FROM `employee_processeds` WHERE `as_symbol` = ? AND `user_id` = ?)",
      symbol,
      current_user.id
    ]

    case symbol.to_sym
    when :FANI
    when :NAGASH
      query[0] = "`id` IN (SELECT `furniture_id` FROM `employee_fanis` WHERE `needs_rang` AND `confirmed`) AND #{query[0]}"
    when :NAJAR
      query[0] = "`id` IN (SELECT `furniture_id` FROM `employee_fanis` WHERE `needs_kanaf` AND `needs_kande` AND `confirmed`) AND #{query[0]}"
    when :KANDE
      query[0] = "`id` IN (SELECT `furniture_id` FROM `employee_fanis` WHERE `needs_kande` AND NOT `needs_kanaf` AND `confirmed`) AND #{query[0]}"
    else
      raise RuntimeError.new("invalid symbol `#{symbol}`")
    end
    
    Admin::Furniture.where(query)    
    
  end
end
