class ChangeCommentTypeFromAdminFurnitureFoamTypes < ActiveRecord::Migration[5.0]
  def change
    change_column :admin_furniture_foam_types, :comment, :text
  end
end
