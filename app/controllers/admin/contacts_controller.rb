class Admin::ContactsController < Admin::AdminbaseController
  before_action :set_admin_contact, only: [:show, :edit, :update, :destroy]
  
  # GET /admin/users
  # GET /admin/users.json
  def index
    @filterrific = initialize_filterrific(Admin::Contact, params[:filterrific]) or return

    @admin_contacts = @filterrific.find.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.js { render partial: 'admin/shared/list' }
    end
  # Recover from invalid param sets, e.g., when a filter refers to the
  # database id of a record that doesn’t exist any more.
  # In this case we reset filterrific and discard all filter params.
  rescue ActiveRecord::RecordNotFound => e
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /admin/contacts/1
  # GET /admin/contacts/1.json
  def show
  end

  # GET /admin/contacts/new
  def new
    @admin_contact = Admin::Contact.new
  end

  # GET /admin/contacts/1/edit
  def edit
  end

  # POST /admin/contacts
  # POST /admin/contacts.json
  def create
    @admin_contact = Admin::Contact.new(admin_contact_params)

    respond_to do |format|
      if @admin_contact.save
        format.html { redirect_to admin_contacts_path, notice: mk_notice(@admin_contact, :id, 'Contact', :create) }
        format.json { render json: @admin_contact, status: :created, location: admin_contacts_path }
      else
        format.html { render :new }
        format.json { render json: @admin_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/contacts/1
  # PATCH/PUT /admin/contacts/1.json
  def update
    respond_to do |format|
      if @admin_contact.update(admin_contact_params)
        format.html { redirect_to admin_contacts_path, notice: mk_notice(@admin_contact, :id, 'Contact', :update) }
        format.json { render json: @admin_contact, status: :ok, location: admin_contacts_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/contacts/1
  # DELETE /admin/contacts/1.json
  def destroy
    @admin_contact.destroy
    respond_to do |format|
      format.html { redirect_to admin_contacts_path, notice: mk_notice(@admin_contact, :id, 'Contact', :destroy) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_contact
      @admin_contact = Admin::Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_contact_params
      params.require(:admin_contact).permit(:name, :phone_numbers, :address, :comment)
    end
end
