class Admin::UploaderController < Admin::AdminbaseController
  def ls_images instance
    obj = {images: instance.images};
    yield obj if block_given?
    respond_to do |format|
      format.json { render json: obj, status: :ok }
    end
  end
  
  def update_uploaded_images(instance, param_name, uploaded_images: :imid, images_to_delete: :images_to_delete, auto_save: false)
    # return if no related data exists
    return unless params[param_name]
    # return if no image uploaded 
    if params[param_name][uploaded_images] 
      # find the uploaded imaged with passed image ids, to make sure of their existance
      instance.append_images Admin::UploadedFile.where(id: params[param_name][uploaded_images]).pluck(:id);
    end
    # if some images want to get deleted
    if params[param_name][images_to_delete]
      # remove those images
      instance.remove_images params[param_name][images_to_delete].map { |id| instance.image_id? id }
    end 
    # save it with condition
    instance.save if auto_save
  end
end
