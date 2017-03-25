class UploaderController < ApplicationController
  
  def update_uploaded_images(instance, param_name, uploaded_images: :imid, images_to_delete: :images_to_delete, auto_save: false)
    # return if no related data exists
    return unless params[param_name]
    # return if no image uploaded 
    if params[param_name][uploaded_images] 
      # find the uploaded imaged with passed image ids
      uploaded_files = UploadedFile.find(params[param_name][uploaded_images]);
      # list uploaded images and append the to current image list
      # this has to be this way; o.w the operation will cost so much time-wise
      instance.images += uploaded_files.map { |m| m.images }.flatten
      # re-create versions of all images  
      instance.images.each { |i| i.recreate_versions! }
      # destroy the temp uploaded images
      # this has to be `destroy_all` to get data cleansed from uploaded file's storage
      # if the native `where().destroy_all` get used, that will select every record first and the destroy them 1-by-1
      # this way atleast we don't have the SELECT overhead
      uploaded_files.each(&:destroy)
    end
    # return if no image wants to get deleted
    if params[param_name][images_to_delete]
      delete_indices = params[param_name][images_to_delete].map(&:to_i)
      
      images = instance.images
      
      images.each.with_index do |i, index|
        i.remove! if delete_indices.include? index
      end
      
      images = images.reject.with_index { |_, index| delete_indices.include? index }
      
      # the hack for carrier wave bug [issue#2141]
      if images.empty?
        instance.write_attribute(:images, nil)
      else      
        instance.images = images
      end
    end 
    # save it with condition
    instance.save if auto_save
  end
end
