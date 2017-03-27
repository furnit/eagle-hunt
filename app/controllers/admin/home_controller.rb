class Admin::HomeController < Admin::AdminbaseController
  def index
    render :layout => 'application'
  end
  def dashboard
  end
end
