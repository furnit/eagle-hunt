class Admin::UsersController < Admin::AdminbaseController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  # GET /admin/users.json
  def index
    @users = User.all.paginate(:page => params[:page])
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @user = User.new(user_params)
    @user.normalize_phone_number
    @user.creator_user_id = current_user.id
    @user.password = @user.phone_number
    @user.password_confirmation = @user.password

    respond_to do |format|
      if @user.save
        # without any call back flag the user should change the password
        @user.write_attribute(:change_password, 1)
        @user.save
        @profile = Profile.new(profile_params.merge(user_id: @user.id))
        @profile.user_id = @user.id;
        @profile.save
        format.html { redirect_to admin_users_path, notice: 'کاربر جدید با موفقیت ساخته شد.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: "کاربر شماره «#{user.id}» با موفقیت بروز رسانی شد." }
        format.json { render :show, status: :ok, location: admin_users_path }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: "کاربر شماره «#{user.id}» با موفقیت حذف شد." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:phone_number, :password, :password_confirmation, :admin_user_type_id)
    end
    def profile_params
      params.require(:user).permit(profile: [ :first_name, :last_name, :address ])[:profile]
    end
end
