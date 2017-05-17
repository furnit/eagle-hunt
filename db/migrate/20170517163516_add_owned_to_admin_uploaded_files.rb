class AddOwnedToAdminUploadedFiles < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_uploaded_files, :owned, :boolean
  end
end
