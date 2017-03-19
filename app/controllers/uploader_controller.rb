class UploaderController < ApplicationController
    def update_uploaded_images(instance, param_name, auto_save: false)
      # return if no image uploaded 
      return unless params[param_name][:imid]
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

end
