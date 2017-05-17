class Admin::HomeController < Admin::AdminbaseController
  # keep flashes for sub-controllers' view to handle
  before_action { flash.keep; flash[:keeped] = true }, only: [:index]
  
  def index
    render :layout => 'application'
  end
  
  def dashboard
  end
end
