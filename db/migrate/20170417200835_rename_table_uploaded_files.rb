class RenameTableUploadedFiles < ActiveRecord::Migration[5.0]
  def change
    rename_table :uploaded_files, :admin_uploaded_files
  end
end
