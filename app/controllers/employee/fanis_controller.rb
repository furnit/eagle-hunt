class Employee::FanisController < Employee::EmployeebaseController
  def index
  end
  
  def new
  end
  
  def create
  end
  
  private
  
  def rokob_params
    params.require(:employee_rokob).permit(:abr_ziri, :abr_poshti, :abr_daste, :dast_mozd)
  end
end
