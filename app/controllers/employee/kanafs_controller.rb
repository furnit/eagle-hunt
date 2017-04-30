class Employee::KanafsController < Employee::EmployeebaseController
  before_action :set_forms_instance, only: [:edit, :create]
  
  def index
  end
  
  def edit
    unless has_processed_before params[:id]
      # this means the user wants to re-evaluate the params
      @form[:kanaf] = Employee::Kanaf.where(furniture_id: params[:id], user_id: current_user.id).last
      # create new records if something is wrong and the kanaf not found
      set_forms_instance and return if not @form[:kanaf] 
      # try to normalize the wages to thousand tomans!
      @form[:kanaf].wage = @form[:kanaf].wage.tomans
    end
  end
  
  def create
    @form[:kanaf] = Employee::Kanaf.new(kanaf_params)
    
    respond_to do |format|
      if @form[:kanaf].valid?
        # destroy all related data from previous un-confirmed details for current furniture and user
        # this will give the user edit-like ability without making database messy and also keeping the confirmed data on touched!
        Employee::Kanaf.where(furniture_id: furniture_params[:id], user_id: current_user.id, confirmed: 0).destroy_all
        
        # save the details
        @form[:kanaf].save
        
        # flag it as unconfirmed data
        @form[:kanaf].furniture.update has_unconfirmed_data: true
        
        # flag current furniture processed by current user
        flag_processed furniture_params[:id]
        
        format.html { redirect_to employee_root_path, notice: 'جزییات با موفقیت ثبت گردید.' }
        format.json { head :no_content, status: :ok, location: employee_root_path }
      else
        format.html { render :edit, layout: false, status: :unprocessable_entity }
        format.json { head status: :unprocessable_entity }
      end
    end 
    
  end
  
  def update_field
    return unless verify_two_step_auth
    p = params[:admin_furniture]
    if p
      p = p[:employee_kanaf]
      if p
        Employee::Kanaf.update(p[:id], kanaf_params(inject: false))
      else
        raise RuntimeError.new("wrong data!")
      end
    else
      raise RuntimeError.new("wrong data!")
    end
  end
  
  private
  
  def set_forms_instance
    @form = {
      furniture: Admin::Furniture.find(params[:id] || furniture_params[:id]).freeze,
      kanaf: Employee::Kanaf.new
    }
  end
  
  def validate_id
    raise Acu::Errors::AccessDenied.new('wrong data!') if not(furniture_params[:hd] == (Digest::SHA256.new << (furniture_params[:id] + Rails.application.config.secret_key_base)).to_s)
  end
  
  def furniture_params
    params.require(:admin_furniture).permit(:id, :hd)
  end
  
  def kanaf_params inject: true
    # purify the params
    par = params.require(:admin_furniture).require(:employee_kanaf).permit(:wage, :choob, :days_to_complete, :days_to_complete_scale)
    # have to convert it to hash to process
    par = par.to_h
    # convert to days, based on defined scale
    par[:days_to_complete] = convert_to_days par[:days_to_complete], par[:days_to_complete_scale] if par[:days_to_complete]
    # purge out un-necessary
    par.delete :days_to_complete_scale
    # add the furniture-id to the collection
    par[:furniture_id] = furniture_params[:id] if inject
    # add the user-id to the collection
    par[:user_id] = current_user.id if inject
    # convert to thousand tomans
    par[:wage] = par[:wage].to_i.thousand_tomans if par[:wage] and inject
    # return the processed params
    par
  end
end
