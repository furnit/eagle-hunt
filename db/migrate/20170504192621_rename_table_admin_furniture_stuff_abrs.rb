class RenameTableAdminFurnitureStuffAbrs < ActiveRecord::Migration[5.0]
  def change
    rename_table :admin_furniture_stuff_abrs, :admin_furniture_foam_types
    remove_column :admin_furniture_foam_types, :value
  end
end
