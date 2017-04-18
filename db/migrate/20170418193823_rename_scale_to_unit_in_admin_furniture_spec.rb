class RenameScaleToUnitInAdminFurnitureSpec < ActiveRecord::Migration[5.0]
  def change
    rename_column :admin_furniture_specs, :scale, :unit
  end
end
