class Employee::FanisController < Employee::EmployeebaseController
  def index
  end
  
  def edit
    @furniture = Admin::Furniture.find(params[:id]).freeze
  end
  
  def create
    byebug
  end
  
  private
  
  def rokob_params
    params.require(:employee_rokob).permit(:abr_ziri, :abr_poshti, :abr_daste, :dast_mozd)
  end
end
