class Employee::EmployeebaseController < ApplicationController
  layout :get_layout
  
  protected
  
  def convert_to_days x, scale
    {
      days: Proc.new { |i| i },
      weeks: Proc.new { |i| i.to_i * 7 },
      months: Proc.new { |i| i.to_i * 30 } 
    }[scale.to_sym].call(x)
  end
  
  def flag_processed id
    # indicate that the user processed the furniture
    # if already procecessed, no exception will raised
    # instead update the updated at column
    proc = Employee::Processed.find_or_create_by(
      admin_furniture_id: id,
      user_id: current_user.id,
      as_symbol: acu_is?(:admin) ? session[:admin_as_employee]["sym"] : current_user.type.symbol
    )
    proc.updated_at = Time.now
    proc.save
  end
  
  def has_processed_before id
    Employee::Processed.where(
      admin_furniture_id: params[:id],
      user_id: current_user.id,
      as_symbol: (acu_is?(:admin) ? session[:admin_as_employee]["sym"] : current_user.type.symbol)).empty?
  end
  
  private
  
  def get_layout
    return false if ["new", "edit", "create"].include? params[:action]
    prefer_layout 'no_navbar'
  end
end
