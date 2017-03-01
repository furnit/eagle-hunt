class PageItemsController < ApplicationController
  before_action :set_page_item, only: [:show, :edit, :update, :destroy]

  # GET /page_items
  # GET /page_items.json
  def index
    @page_items = PageItem.all
  end

  # GET /page_items/1
  # GET /page_items/1.json
  def show
  end

  # GET /page_items/new
  def new
    @page_item = PageItem.new
  end

  # GET /page_items/1/edit
  def edit
  end

  # POST /page_items
  # POST /page_items.json
  def create
    @page_item = PageItem.new(page_item_params)

    respond_to do |format|
      if @page_item.save
        format.html { redirect_to @page_item, notice: 'Page item was successfully created.' }
        format.json { render :show, status: :created, location: @page_item }
      else
        format.html { render :new }
        format.json { render json: @page_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /page_items/1
  # PATCH/PUT /page_items/1.json
  def update
    respond_to do |format|
      if @page_item.update(page_item_params)
        format.html { redirect_to @page_item, notice: 'Page item was successfully updated.' }
        format.json { render :show, status: :ok, location: @page_item }
      else
        format.html { render :edit }
        format.json { render json: @page_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_items/1
  # DELETE /page_items/1.json
  def destroy
    @page_item.destroy
    respond_to do |format|
      format.html { redirect_to page_items_url, notice: 'Page item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_item
      @page_item = PageItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_item_params
      params.require(:page_item).permit(:controller, :action, :details)
    end
end
