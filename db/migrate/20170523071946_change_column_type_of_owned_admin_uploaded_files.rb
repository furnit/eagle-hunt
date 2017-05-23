class ChangeColumnTypeOfOwnedAdminUploadedFiles < ActiveRecord::Migration[5.0]
  def change
    change_column :admin_uploaded_files, :owned, :integer
  end
end
