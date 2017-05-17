class AddOwnedToAdminUploadedFiles < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_uploaded_files, :owned, :boolean, default: false
    add_index :admin_uploaded_files, :owned
  end
end
