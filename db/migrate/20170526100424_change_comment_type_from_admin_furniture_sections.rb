class ChangeCommentTypeFromAdminFurnitureSections < ActiveRecord::Migration[5.0]
  def change
    change_column :admin_furniture_sections, :comment, :text
  end
end
