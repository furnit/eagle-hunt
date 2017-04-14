class Employee::FanisController < Employee::EmployeebaseController
  before_action :validate_id, only: [:create]
  before_action :set_forms_instance, only: [:edit, :create]
  
  def index
  end
  
  def edit
    @furniture = Admin::Furniture.find(params[:id]).freeze
  end
  
  def create    
    @form[:fani] = Employee::Fani.new(fanis_params)
    
    @form[:build_details] = []
    
    build_details_params[:spec].each do |spec_id, sections|
      sections[:section].each do |section_id, params|
        params[:options] = { } if not params[:options]
        params = params.slice(:value, :options)
        
        @form[:build_details] << FurnitureBuildDetail.new(
          admin_furniture_specs_id: spec_id, 
          admin_furniture_sections_id: section_id,
          value: params[:value],
          options: params[:options])
      end
    end
    
    valid = [] 
    valid << @form[:fani].validate
    @form[:build_details].each { |f| valid << f.validate }
    
    respond_to do |format|
      if valid.all?
        @form[:fani].save
        @form[:build_details].each { |f| f.save }
        format.html { redirect_to employee_root_path, notice: 'جزییات با موفقیت ثبت گردید.' }
        format.json { head :no_content, status: :ok, location: admin_users_path }
      else
        format.html { render :edit, layout: false, status: :unprocessable_entity }
        format.json { head :no_content, status: :unprocessable_entity }
      end
    end 
  end
  
  private
  
  def set_forms_instance
    @form = {
      furniture: Admin::Furniture.find(params[:id] || furniture_params[:id]).freeze,
      fani: Employee::Fani.new,
      build_details: []
    }
    6.times { @form[:build_details] << FurnitureBuildDetail.new }
  end
  
  def validate_id
    raise Acu::Errors::AccessDenied.new('wrong data!') if not(furniture_params[:hd] == (Digest::SHA256.new << (furniture_params[:id] + Rails.application.config.secret_key_base)).to_s)
  end
  
  def furniture_params
    params.require(:admin_furniture).permit(:id, :hd)
  end
  
  def build_details_params
    params.require(:admin_furniture).require(:employee_fani).require(:furniture_build_detail)
  end
  
  def fanis_params
    # purify the params
    par = params.require(:admin_furniture).require(:employee_fani).permit(:wage_rokob, :wage_khayat, :days_to_complete, :days_to_complete_scale, :needs_kande, :needs_kanaf, :needs_rang)
    # have to convert it to hash to process
    par = par.to_h
    # convert to days, based on defined scale
    par[:days_to_complete] = {
      days: Proc.new { |i| i },
      weeks: Proc.new { |i| i.to_i * 7 },
      months: Proc.new { |i| i.to_i * 30 } 
    }[par[:days_to_complete_scale].to_sym].call(par[:days_to_complete])
    # purge out un-necessary
    par.delete :days_to_complete_scale
    # add the furniture-id to the collection
    par[:furnitures_id] = furniture_params[:id]
    # add the user-id to the collection
    par[:users_id] = current_user.id
    # convert to thousand tomans
    [:wage_rokob, :wage_khayat].each { |i| par[i] = par[i].to_i * 1000 }
    # return the processed params
    par
  end
end
