class UploadedFilesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = UploadedFile.new(picture_params)
    
    respond_to do |format|
      if @picture.save
        format.json { render json: {files: @picture.to_jq_upload}, status: :created, location: @picture }
      else
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = UploadedFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:uploaded_files).permit({images: []})
    end
end
