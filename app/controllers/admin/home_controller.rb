class Admin::HomeController < Admin::AdminbaseController
  def index
    render :layout => 'application'
  end
  def dashboard
  end
  
  def users
    @users = User.all.paginate(:page => params[:page])
  end
end
