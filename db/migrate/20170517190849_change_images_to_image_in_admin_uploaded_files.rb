class ChangeImagesToImageInAdminUploadedFiles < ActiveRecord::Migration[5.0]
  def change
    rename_column :admin_uploaded_files, :images, :image
  end
end
