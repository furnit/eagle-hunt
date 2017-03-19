class UploaderController < ApplicationController
  
  def update_uploaded_images(instance, param_name, auto_save: false)
    # return if no image uploaded 
    return unless params[param_name] and params[param_name][:imid]
    # find the uploaded imaged with passed image ids
    uploaded_files = UploadedFile.find(params[param_name][:imid]);
    # list uploaded images and append the to current image list 
    uploaded_files.each { |m| instance.images += m.images }
    # re-create versions of all images  
    instance.images.each { |i| i.recreate_versions! }
    # destroy the temp uploaded images
    uploaded_files.each { |u| u.destroy }
    # save it with condition
    instance.save if auto_save
  end

  def delete_instance_image instance
    # list current images
    remain_images = instance.images
    # delete the target image from the list
    deleted_image = remain_images.delete_at(params.permit(:i)[:i].to_i)
    # remove the actual file from the FS
    deleted_image.remove!
    # the hack for carrier wave bug [issue#2141]
    if remain_images.empty?
      instance.write_attribute(:images, nil)
    else      
      instance.images = remain_images  
    end
  end
end
