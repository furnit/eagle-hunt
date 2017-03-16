class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    
    @pictures = Picture.all

    respond_to do |format|
      format.html { render :layout => true }# index.html.erb
      format.json { render json: @pictures.map{|picture| pictures.to_jq_upload } }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/new
  def new
    @picture = Picture.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    
    respond_to do |format|
      if @picture.save
        format.html {
          render :json => {files: [@picture.to_jq_upload]},
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@picture.to_jq_upload]}, status: :created, location: @picture }
      else
        format.html { render action: "new" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit({images: []})
    end
end
