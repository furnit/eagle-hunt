class Admin::HomeController < Admin::AdminbaseController
  # keep flashes for sub-controllers' view to handle
  before_action :keep_flash, only: [:index]
  
  def index
    render :layout => 'application'
  end
  
  def dashboard
  end
  
  protected
  
  def keep_flash
    flash.keep; flash[:keeped] = true 
  end
end
