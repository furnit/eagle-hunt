class Admin::UsersController < Admin::AdminbaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :block, :reset_password]

  # GET /admin/users
  # GET /admin/users.json
  def index
    @filterrific = initialize_filterrific(User, params[:filterrific]) or return

    @users = @filterrific.find.with_deleted.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  # Recover from invalid param sets, e.g., when a filter refers to the
  # database id of a record that doesn’t exist any more.
  # In this case we reset filterrific and discard all filter params.
  rescue ActiveRecord::RecordNotFound => e
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
    respond_to do |format|
      format.html { render json: @user, status: :ok }
      format.json { render json: @user, status: :ok }
    end
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
        Profile.new(profile_params.merge(user_id: @user.id)).save
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
    notice = "کاربر شماره «<b>#{@user.id}</b>» با موفقیت بروز رسانی شد."
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: notice }
        format.json { render json: @user, status: :ok, location: admin_users_path }
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
      format.html { redirect_to admin_users_path, notice: "کاربر شماره «<b>#{@user.id}</b>» با موفقیت حذف شد." }
      format.json { head :no_content }
    end
  end

  # DELETE /admin/users/1/block
  # DELETE /admin/users/1/block.json
  def block
    # block the user
    @user.blocked_at = @user.blocked_at ? nil : Time.now
    @user.save
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: "کاربر شماره «<b>#{@user.id}</b>» با موفقیت %s شد." %[@user.blocked_at ? 'مسدود' : 'باز'] }
      format.json { head :no_content }
    end
  end

  # GET /admin/users/states
  def states
    respond_to do |format|
      format.json { render json: State.all.map {|i| {value: i.id, text: i.name}}, status: :ok }
    end
  end

  def reset_password
    @user.reset_password
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: "رمز کاربر شماره «<b>#{@user.id}</b>» با موفقیت به «<b>به شماره تماس</b>» وی بروز رسانی شد." }
        format.json { render json: @user, status: :ok, location: admin_users_path }
      else
        format.html { redirect_to admin_users_path, error: "تغییر رمز عبور موفقیت‌آمیز <b>بود</b>." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def send_temp_password_token
    current_user.temp_password_token = Digest::SHA256.hexdigest([Time.now, rand].join)[0..AppConfig.passwords.temp_token_length];
    current_user.temp_password_token_sent_at = Time.now
    current_user.save
    AutoStart::SmsJob.send_urgent current_user.temp_password_token, to: current_user.phone_number
    
    debug
    # todo
    
    respond_to do |format|
      format.html { }
      format.json { }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.with_deleted.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:phone_number, :password, :password_confirmation, :admin_user_type_id,)
    end
    def profile_params
      params.require(:user).permit(profile: [ :first_name, :last_name, :address, :state_id ])[:profile]
    end
end
