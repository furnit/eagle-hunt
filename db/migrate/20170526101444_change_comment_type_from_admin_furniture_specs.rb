class ChangeCommentTypeFromAdminFurnitureSpecs < ActiveRecord::Migration[5.0]
  def change
    change_column :admin_furniture_specs, :comment, :text
  end
end
